import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String title;
  final Color color;
  final TextEditingController controller;
  final Function handler;

  InputFieldWidget(
    this.title,
    this.color,
    this.controller,
    this.handler,
  );

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  FocusNode _myFocusNode = new FocusNode();
  Color _textColor;

  @override
  void initState() {
    super.initState();
    _myFocusNode.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    _myFocusNode.removeListener(listener);
  }

  void listener() {
    Color hasColor;
    if (_myFocusNode.hasFocus) {
      hasColor = widget.color;
    } else {
      hasColor = Colors.black54;
    }

    setState(() {
      _textColor = hasColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _myFocusNode,
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'RobotoSlab',
          color: _textColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
        ),
      ),
      cursorColor: widget.color,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onSubmitted: (_) => widget.handler,
    );
  }
}
