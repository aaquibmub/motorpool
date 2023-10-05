import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_enroute_item_widget.dart';
import 'package:provider/provider.dart';

import '../trip_summary_widget.dart';

class TripEnrouteWidget extends StatelessWidget {
  final TripEnroute _tripEnroute;
  final Function _updateState;

  TripEnrouteWidget(
    this._tripEnroute,
    this._updateState,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: InkWell(
                  onTap: () => {},
                  child: Icon(Icons.access_alarm),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () => {},
                  child: Icon(Icons.access_alarm),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: _tripEnroute != null
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TripSummaryWiget(
                          _tripEnroute.tripRoute,
                          _tripEnroute.tripDestination,
                          _tripEnroute.numberOfLocations,
                          _tripEnroute.numberOfPassengers,
                        ),
                        _tripEnroute.items.length > 0
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ..._tripEnroute.items
                                        .map((i) => TripEnrouteItemWidget(i))
                                        .toList(),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text("no trip found"),
                              )
                      ],
                    ),
                  )
                : Center(
                    child: Text("no trip found"),
                  ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            color: Constants.colorGreen,
            onPressed: () {
              Provider.of<TripProvider>(context, listen: false)
                  .updateStatus(
                TripStatusUpdate(
                  _tripEnroute.tripId,
                  Utility.getNextTripStatus(
                    _tripEnroute.tripStatus,
                  ),
                  Utility.getNextTripAddressId(_tripEnroute),
                  '',
                ),
              )
                  .then((response) {
                _updateState();
              });
            },
            child: Text(
              Utility.getTripEnrouteButtonText(
                _tripEnroute.tripStatus,
              ),
              style: Theme.of(context).primaryTextTheme.button,
            ),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        )
      ],
    );
  }
}
