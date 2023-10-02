import 'package:flutter/cupertino.dart';
import 'package:motorpool/helpers/common/constants.dart';

class BadgeWidget extends StatelessWidget {
  final IconData _icon;
  final String _label;

  BadgeWidget(
    this._icon,
    this._label,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.colorBadgeBg,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              _icon,
              size: 10,
            ),
          ),
          Expanded(
            flex: 1,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 9,
                color: Constants.colorBadgeTitle,
              ),
              child: Text(_label),
            ),
          )
        ],
      ),
    );
  }
}
