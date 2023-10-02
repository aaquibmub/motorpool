import 'package:flutter/material.dart';

class AddressCardWidget extends StatelessWidget {
  final String _label;
  final String _value;
  final String _valueEx;

  AddressCardWidget(
    this._label,
    this._value,
    this._valueEx,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Text(_label),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Text(_value ?? ""),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Text(_valueEx ?? ""),
        ),
      ],
    );
  }
}
