import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:provider/provider.dart';

import '../../../../screens/home/trips/enroute/trip_enroute_screen.dart';

class TripWaitingForPassengerWidget extends StatefulWidget {
  final TripEnroute _tripEnroute;
  // final Function _updateState;

  TripWaitingForPassengerWidget(
    this._tripEnroute,
    // this._updateState,
  );

  @override
  State<TripWaitingForPassengerWidget> createState() =>
      _TripWaitingForPassengerWidgetState();
}

class _TripWaitingForPassengerWidgetState
    extends State<TripWaitingForPassengerWidget> {
  String _timeString = "";
  int timeInSeconds = 0;
  Timer _timer;

  @override
  void initState() {
    final nowTime = DateTime.now();
    final latestItem =
        widget._tripEnroute.items[widget._tripEnroute.items.length - 2];
    final startTime = latestItem != null && latestItem.startTime != null
        ? new DateFormat("hh:mm aa").parseLoose(latestItem.start)
        : null;
    final updatedTime = new DateTime(
      nowTime.year,
      nowTime.month,
      nowTime.day,
      startTime.hour,
      startTime.minute,
      startTime.second,
    );
    // final seconds = latestItem != null && latestItem.startTime != null
    //     ? DateTime.now().difference(latestItem.startTime).inSeconds
    //     : 0;
    final seconds = startTime != null
        ? DateTime.now().difference(updatedTime).inSeconds
        : 0;

    setState(() {
      timeInSeconds = seconds;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeInSeconds++;
        _timeString = Utility.formatHHMMSS(timeInSeconds);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Text(
            'WAITING FOR ${widget._tripEnroute.tripType == TripType.Refuelling ? 'REFUELLING' : 'PASSENGER'}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _timeString,
                  style: TextStyle(
                    color: Constants.colorOrange,
                    fontSize: 45,
                  ),
                ),
                Text(
                  'TIME ELAPSED',
                  style: TextStyle(
                    color: Constants.colorOrange,
                    fontSize: 14,
                  ),
                )
              ],
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
                widget._tripEnroute,
              );
              Provider.of<TripProvider>(context, listen: false)
                  .updateStatus(
                TripStatusUpdate(
                  widget._tripEnroute.tripId,
                  tripStatus,
                  Utility.getNextTripDestinationId(widget._tripEnroute),
                  Utility.getNextTripAddressId(widget._tripEnroute),
                  '',
                ),
              )
                  .then((response) {
                // widget._updateState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TripEnrouteScreen(
                            widget._tripEnroute.tripId,
                          )),
                );
              });
            },
            child: Text(
              'RESUME TRIP',
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
