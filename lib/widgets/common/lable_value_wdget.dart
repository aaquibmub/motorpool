import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';

class LabelValueWidget extends StatelessWidget {
  final String _label;
  final String _value;

  LabelValueWidget(
    this._label,
    this._value,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Text(
            _label,
            style: TextStyle(
              color: Constants.textColorLight,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Constants.colorCardBorder,
              ),
            ),
          ),
          child: Text(_value ?? "",
              style: TextStyle(
                color: Constants.textColor,
                fontSize: 14,
              )),
        )
      ],
    );
  }
}
