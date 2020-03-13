import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/calculate_button.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/output_result_widget.dart';

import '../data/data.dart';

class CastingWeightScreen extends StatefulWidget {
  static const routeName = '/casting-weight';

  @override
  _CastingWeightScreenState createState() => _CastingWeightScreenState();
}

class _CastingWeightScreenState extends State<CastingWeightScreen> {
  final _volumeController = TextEditingController(text: Data.volume);
  final _densityController = TextEditingController(text: Data.density);
  double _castingWeight = 0;

  void _calculateData() {
    if (_volumeController.text.isEmpty || _densityController.text.isEmpty) {
      return;
    }
    final entertedVolume = double.parse(_volumeController.text);
    final enteredDensity = double.parse(_densityController.text);

    if (entertedVolume.isNegative || enteredDensity.isNegative) {
      return;
    }

    setState(() {
      _castingWeight = entertedVolume * enteredDensity * pow(10, -6);

      // Add values to data file
      Data.volume = _volumeController.text;
      Data.density = _densityController.text;
      Data.castingWeight = _castingWeight.toString();
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
          'Casting Weight',
        ),
        backgroundColor: _color2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          InputFieldWidget(
            'Volume of Casting (mm³)',
            _color2,
            _volumeController,
            _calculateData,
          ),
          SizedBox(
            height: 20,
          ),
          InputFieldWidget(
            'Density (x10^-6 Kg/mm³)',
            _color2,
            _densityController,
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
            'Casting Weight',
            _castingWeight,
            'Kg',
          ),
        ],
      ),
    );
  }
}
