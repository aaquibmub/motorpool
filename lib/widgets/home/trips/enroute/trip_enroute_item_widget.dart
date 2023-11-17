import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute_item.dart';

class TripEnrouteItemWidget extends StatelessWidget {
  final TripEnrouteItem _item;

  TripEnrouteItemWidget(
    this._item,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: _item.title.toLowerCase() == 'waiting'
              ? Constants.colorDarkYellow
              : _item.completed
                  ? Constants.colorDarkGreen
                  : Constants.colorCardBorder,
        ),
        color: _item.title.toLowerCase() == 'waiting'
            ? Constants.colorYellow
            : _item.completed
                ? Constants.colorLightGreen
                : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _item.start == null || _item.start == "" ? "" : _item.start,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _item.end == null || _item.end == "" ? "" : _item.end,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            _item.title == null || _item.title == "" ? "" : _item.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _item.location == null || _item.location.text == null
                ? ""
                : _item.location.text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
