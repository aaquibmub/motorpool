import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute_item.dart';

class TripEnrouteItemWidget extends StatelessWidget {
  final TripEnrouteItem _item;

  TripEnrouteItemWidget(
    this._item,
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_item.title == "" ? "No title" : _item.title),
    );
  }
}
