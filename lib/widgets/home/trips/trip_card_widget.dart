import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/models/trips/trip.dart';
import 'package:motorpool/screens/home/trips/detail/trip_detail_screen.dart';
import 'package:motorpool/screens/home/trips/enroute/trip_enroute_screen.dart';
import 'package:motorpool/widgets/common/lable_value_wdget.dart';
import 'package:motorpool/widgets/home/trips/trip_summary_widget.dart';

class TripCardWidget extends StatelessWidget {
  final Trip _trip;

  TripCardWidget(
    this._trip,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (_trip.tripStatus.value <= TripStatus.AssignedToDriver) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripDetailScreen(
                        _trip.id,
                      )),
            );
          }
          if (_trip.tripStatus.value > TripStatus.AssignedToDriver &&
              _trip.tripStatus.value < TripStatus.Completed) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripEnrouteScreen(
                        _trip.id,
                      )),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: new EdgeInsets.all(8),
              padding: EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: Text(
                _trip.pickupTime,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Constants.colorCardBorder,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TripSummaryWiget(
                    _trip.tripRoute.text,
                    _trip.tripDestination.text,
                    _trip.numberOfLocations,
                    _trip.numberOfPassenger,
                  ),
                  LabelValueWidget(
                    "TRIP ID",
                    _trip.tripId,
                  ),
                  LabelValueWidget(
                    "DATE/TIME",
                    _trip.pickupTime,
                  ),
                  LabelValueWidget(
                    "PASSENGER NAME",
                    _trip.requester,
                  ),
                  LabelValueWidget(
                    "PICKUP LOCATION",
                    _trip.pickupLocation,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
