import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/calculate_button.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/output_result_widget.dart';

import '../data/data.dart';

class ChokeAreaScreen extends StatefulWidget {
  static const routeName = '/choke-area';

  @override
  _ChokeAreaScreenState createState() => _ChokeAreaScreenState();
}

class _ChokeAreaScreenState extends State<ChokeAreaScreen> {
  final _weightWithGratingController =
      TextEditingController(text: Data.weightcs);
  final _densityController = TextEditingController(text: Data.den);
  final _pouringTimeController = TextEditingController(text: Data.pouringTime);
  final _sprueHeightController = TextEditingController(text: Data.sprueHeight);
  final _etaController = TextEditingController(text: Data.eta);
  final _hbController = TextEditingController(text: Data.hb);
  //final _a2Controller = TextEditingController(text: Data.a2);
 // final _weightController = TextEditingController(text: Data.weightcs);
  double _chokeArea = 0;
  double _a2=0;
  double _dsb=0;

  void _calculateData() {
    if (_weightWithGratingController.text.isEmpty ||
        _densityController.text.isEmpty ||
        _pouringTimeController.text.isEmpty ||
        _sprueHeightController.text.isEmpty ||
        _etaController.text.isEmpty) {
      return;
    }

    final enteredWeight = double.parse(_weightWithGratingController.text);
    final enteredDensity = double.parse(_densityController.text);
    final enteredPouringTime = double.parse(_pouringTimeController.text);
    final enteredSprueHeight = double.parse(_sprueHeightController.text);
    final enteredEta = double.parse(_etaController.text);
    final hb = double.parse(_hbController.text);
    //final enteredEta = double.parse(_etaController.text);

    if (enteredWeight.isNegative ||
        enteredDensity.isNegative ||
        enteredDensity == 0 ||
        enteredSprueHeight.isNegative ||
        enteredSprueHeight == 0 ||
        enteredPouringTime.isNegative ||
        enteredPouringTime == 0 ||
        enteredEta.isNegative ||
        enteredEta == 0) {
      return;
    }

    final denominator = enteredDensity *
        pow(10, -6) *
        enteredPouringTime *
        enteredEta *
        sqrt(2 * 9.81 * enteredSprueHeight * pow(10, 3)) ; //Converted to mm²

    setState(() {
      _chokeArea = enteredWeight / denominator;
      _dsb=sqrt((_chokeArea*4)/3.14);
      _a2=_chokeArea*sqrt( enteredSprueHeight/hb);

      // Add values to data file
      Data.weightWithGrating = _weightWithGratingController.text;
      Data.density = _densityController.text;
      Data.pouringTime = _pouringTimeController.text;
      Data.eta = _etaController.text;
      Data.sprueHeight = _sprueHeightController.text;
      Data.chokeArea = _chokeArea.toString();
      Data.dsb=_dsb.toString();
      Data.a2=_a2.toString();
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
        title: Text('Choke Area'),
        backgroundColor: _color2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          InputFieldWidget(
            'Weight with grating(Kg)',
            _color2,
            _weightWithGratingController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Density(x10^-6 Kg/mm³)',
            _color2,
            _densityController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Pouring Time(sec)',
            _color2,
            _pouringTimeController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
           InputFieldWidget(
            'Height for basin(mm)',
            _color2,
            _hbController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Eta[η] (varies between 0.7-0.9) ',
            _color2,
            _etaController,
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
          CalculateButton(
            _color2,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          OutputResultWidget(
            'Choke Area',
            _chokeArea,
            'mm²',
          ),
           OutputResultWidget(
            'dsb',
            _dsb,
            'mm',
          ),
          OutputResultWidget(
            'A₂',
            _a2,
            'mm²',
          ),
        ],
      ),
    );
  }
}
