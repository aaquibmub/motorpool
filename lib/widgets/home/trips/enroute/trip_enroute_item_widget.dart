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
          color: _item.completed ? Constants.colorGreen : Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_item.start == null || _item.start == "" ? "" : _item.start),
              Text(_item.end == null || _item.end == "" ? "" : _item.end),
            ],
          ),
          Text(_item.title == null || _item.title == ""
              ? "No title"
              : _item.title),
          Text(_item.location == null || _item.location.text == null
              ? "<address-missing>"
              : _item.location.text),
        ],
      ),
    );
  }
}
