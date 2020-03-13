import 'package:flutter/material.dart';

import '../widgets/calculate_button.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/output_result_widget.dart';

import '../data/data.dart';

class CastingModuleScreen extends StatefulWidget {
  static const routeName = '/casting-module';
  @override
  _CastingModuleScreenState createState() => _CastingModuleScreenState();
}

class _CastingModuleScreenState extends State<CastingModuleScreen> {
  final _volumeController = TextEditingController(text: Data.volume);
  final _surfaceAreaController = TextEditingController(text: Data.surfaceArea);
  double _modules = 0;
  void _calculateData() {
    if (_volumeController.text.isEmpty || _surfaceAreaController.text.isEmpty) {
      return;
    }
    final entertedVolume = double.parse(_volumeController.text);
    final enteredSurfaceArea = double.parse(_surfaceAreaController.text);

    if (entertedVolume.isNegative ||
        enteredSurfaceArea.isNegative ||
        enteredSurfaceArea == 0) {
      return;
    }

    setState(() {
      _modules = entertedVolume / enteredSurfaceArea;

      // Add values to data file
      Data.volume = _volumeController.text;
      Data.surfaceArea = _surfaceAreaController.text;
      Data.module = _modules.toString();
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
          'Casting Module',
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
            'Surface Area (mm²)',
            _color2,
            _surfaceAreaController,
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
            'Casting Module',
            _modules,
            'mm',
          ),
        ],
      ),
    );
  }
}
