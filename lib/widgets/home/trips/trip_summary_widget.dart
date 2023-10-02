import 'package:flutter/material.dart';
import 'package:motorpool/widgets/common/badge_widget.dart';

class TripSummaryWiget extends StatelessWidget {
  final String _tripRoute;
  final String _tripDestination;
  final int _numberOfLocations;
  final int _numberOfPassengers;

  TripSummaryWiget(
    this._tripRoute,
    this._tripDestination,
    this._numberOfLocations,
    this._numberOfPassengers,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: BadgeWidget(
              Icons.ac_unit,
              _tripRoute,
            ),
          ),
          Expanded(
            flex: 2,
            child: BadgeWidget(
              Icons.ac_unit,
              _tripDestination,
            ),
          ),
          Expanded(
            flex: 1,
            child: BadgeWidget(
              Icons.ac_unit,
              _numberOfLocations.toString(),
            ),
          ),
          Expanded(
            flex: 1,
            child: BadgeWidget(
              Icons.ac_unit,
              _numberOfPassengers.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
