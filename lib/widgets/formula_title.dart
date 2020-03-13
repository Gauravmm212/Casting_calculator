import 'package:flutter/material.dart';

class FormulaTitle extends StatelessWidget {
  final String title;
  final Color color1;
  final Color color2;
  final String routeHandle;

  FormulaTitle({
    this.title,
    this.color1,
    this.color2,
    this.routeHandle,
  });

  void tapHandler(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      routeHandle,
      arguments: {'color1': color1, 'color2': color2},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tapHandler(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: color1,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
