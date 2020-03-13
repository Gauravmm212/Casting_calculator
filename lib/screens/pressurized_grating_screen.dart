import 'package:flutter/material.dart';
import '../widgets/calculate_button.dart';
import '../widgets/input_field_widget.dart';
import '../widgets/output_result_widget.dart';
import '../data/data.dart';
import 'dart:math';

class PressurizedGratingScreen extends StatefulWidget {
   static const routeName = '/pressurized-grating';
  @override
  _PressurizedGratingScreen createState() => _PressurizedGratingScreen();
}

class _PressurizedGratingScreen extends State<PressurizedGratingScreen> {
    final _weightWithGratingController =
      TextEditingController(text: Data.fca);
      final _gateController =
      TextEditingController(text: Data.gate);
  
  //final _a2Controller = TextEditingController(text: Data.a2);
 // final _weightController = TextEditingController(text: Data.weightcs);
  double _ar = 0;
  double _wt=0;
  double _ht=0;
  double _ag=0;
  double _iag=0;
  double _ght=0;
  double _gwt=0;
  
  void _calculateData() {
    if (_gateController.text.isEmpty
        ) {
      return;
    }

    final enteredWeight = double.parse(_weightWithGratingController.text);
   final gate = double.parse(_gateController.text);
   
    //final enteredEta = double.parse(_etaController.text);w

    if (gate.isNegative ) {
      return;
    }

    

    setState(() {
      _ar = enteredWeight*2;
      _ht=sqrt(_ar);
      _wt=_ht;
      _ag=enteredWeight;
      _iag=_ag/gate;
      _ght=sqrt(_iag/2);
      _ght=_ght.ceilToDouble();
      _gwt=2*_ght;
      // Add values to data file
      Data.arp = _ar.toString();
      Data.agp = _ag.toString();
      
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
        title: Text('Pressurized Grating'),
        backgroundColor: _color2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          InputFieldWidget(
            'Number of ingate:',
            _color2,
            _gateController,
            _calculateData,
          ),
            SizedBox(
            height: 20,
          ),
          CalculateButton(
            _color2,
            _calculateData,
          ),
         
          OutputResultWidget(
            'Runner area',
            _ar,
            'mm²²',
          ),
           OutputResultWidget(
            'Height',
            _ht,
            'mm',
          ),
          OutputResultWidget(
            'Width',
            _wt,
            'mm',
          ),
           OutputResultWidget(
            'Ingate area',
            _ag,
            'mm²',
          ),
          OutputResultWidget(
            'Area of each ingate',
            _iag,
            'mm²',
          ),
          OutputResultWidget(
            'Height of ingate',
            _ght,
            'mm',
          ),
          OutputResultWidget(
            'Width of ingate',
            _gwt,
            'mm',
          ),
          
        
        ],
      ),
    );
  }
  }

