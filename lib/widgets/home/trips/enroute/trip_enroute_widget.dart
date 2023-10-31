import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/screens/destinations/add_trip_destination_screen.dart';
import 'package:motorpool/screens/home/trip_screen.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_enroute_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../screens/home/trips/enroute/trip_enroute_screen.dart';
import '../trip_summary_widget.dart';

class TripEnrouteWidget extends StatelessWidget {
  final TripEnroute _tripEnroute;
  // final Function _updateState;

  TripEnrouteWidget(
    this._tripEnroute,
    // this._updateState,
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
                height: 50,
                child: InkWell(
                  onTap: () {
                    final int sequence = _tripEnroute
                        .items[_tripEnroute.items.length - 1].sequence;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTripDestinationScreen(
                                _tripEnroute.tripId,
                                sequence,
                              )),
                    );
                  },
                  child: new SvgPicture.asset(
                    Constants.svgPathAddDropoff,
                    semanticsLabel: 'Add Destination',
                    color: Colors.white,
                  ),
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
                    child: SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Constants.colorGreen,
              ),
            ),
            onPressed: () {
              final tripStatus = Utility.getNextTripStatus(
                _tripEnroute,
              );
              Provider.of<TripProvider>(context, listen: false)
                  .updateStatus(
                TripStatusUpdate(
                  _tripEnroute.tripId,
                  tripStatus,
                  Utility.getNextTripDestinationId(_tripEnroute),
                  Utility.getNextTripAddressId(_tripEnroute),
                  '',
                ),
              )
                  .then((response) {
                if (response.hasError) {
                  Utility.errorAlert(context, null, response.msg);
                  return;
                }
                if (tripStatus == TripStatus.Completed) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripScreen(),
                    ),
                  );
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TripEnrouteScreen(
                            _tripEnroute.tripId,
                          )),
                );
              });
            },
            child: Text(
              Utility.getTripEnrouteButtonText(_tripEnroute),
              style: Theme.of(context).primaryTextTheme.labelLarge,
            ),
            // elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        )
      ],
    );
  }
}
