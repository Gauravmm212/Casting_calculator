import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final Color color;
  final Function tapHandler;

  CalculateButton(this.color, this.tapHandler);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      onPressed: tapHandler,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      color: color,
      child: Text(
        'Calculate',
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
