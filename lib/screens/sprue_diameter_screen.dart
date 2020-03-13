import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/calculate_button.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/output_result_widget.dart';

import '../data/data.dart';

class SprueDiameterScreen extends StatefulWidget {
  static const routeName = '/sprue-diameter';

  @override
  _SprueDiameterScreenState createState() => _SprueDiameterScreenState();
}

class _SprueDiameterScreenState extends State<SprueDiameterScreen> {
  final _chokeAreaController = TextEditingController(text: Data.a2);
  final _sprueHeightController = TextEditingController(text: Data.sprueHeight);
  final _basinHeightController = TextEditingController(text: Data.basinHeight);
   final _fdsbController = TextEditingController(text: Data.dsb);
    //final _basinHeightController = TextEditingController(text: Data.basinHeight);
  double _sprueArea = 0;
  double _sprueDiameter = 0;
  double _fdsb=0;
  double _fdst=0;
  double _fca=0;
  double _sl=0;

  void _calculateData() {
    if (_chokeAreaController.text.isEmpty ||
        _basinHeightController.text.isEmpty ||
        _sprueHeightController.text.isEmpty) {
      return;
    }

    final enteredChokeArea = double.parse(_chokeAreaController.text);
    final enteredSprueHeight = double.parse(_sprueHeightController.text);
    final enteredBasinHeight = double.parse(_basinHeightController.text);
    final mm = double.parse(_fdsbController.text);


    if (enteredChokeArea <= 0 ||
        enteredBasinHeight <= 0 ||
        enteredSprueHeight <= 0) {
      return;
    }

    setState(() {
      _sprueArea =
          enteredChokeArea * sqrt(enteredSprueHeight / enteredBasinHeight);
      _sprueDiameter = sqrt(enteredChokeArea * 4 / pi);
      _fdst=_sprueDiameter.ceilToDouble();
      _fdsb=mm.ceilToDouble();
      _fca=(pi*_fdsb*_fdsb)/4;
      _sl=enteredSprueHeight-enteredBasinHeight;
      // Add values to data file
      Data.chokeArea = _chokeAreaController.text;
      Data.sprueHeight = _sprueHeightController.text;
      Data.basinHeight = _basinHeightController.text;
      Data.surfaceArea = _sprueArea.toString();
      Data.sprueDiameter = _sprueDiameter.toString();
      Data.fca = _fca.toString();
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Color>;
    //final Color _color1 = routeArgs['color1'];
    final Color _color2 = routeArgs['color2'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sprue Diameter',
        ),
        backgroundColor: _color2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          InputFieldWidget(
            'A₂(mm²)',
            _color2,
            _chokeAreaController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Sprue Height(mm)',
            _color2,
            _sprueHeightController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Basin Height(mm)',
            _color2,
            _basinHeightController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          CalculateButton(
            _color2,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
         
          OutputResultWidget(
            'Final Sprue diameter at top',
            _fdst,
            'mm',
          ),
          OutputResultWidget(
            'Final Sprue diameter at bottom',
            _fdsb,
            'mm',
          ),
           OutputResultWidget(
            'Final Choke area',
            _fca,
            'mm²',
          ),
           OutputResultWidget(
            'Sprue Length',
            _sl,
            'mm',
          ),
        ],
      ),
    );
  }
}
