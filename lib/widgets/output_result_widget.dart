import 'package:flutter/material.dart';

class OutputResultWidget extends StatelessWidget {
  final String title;
  final double value;
  final String unit;

  OutputResultWidget(this.title, this.value, this.unit);

  @override
  Widget build(BuildContext context) {
    return value == 0
        ? Text(
            '$title:',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoSlab',
            ),
          )
        : SelectableText(
            '$title: ${value.toStringAsFixed(4)} $unit',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoSlab',
            ),
          );
  }
}
