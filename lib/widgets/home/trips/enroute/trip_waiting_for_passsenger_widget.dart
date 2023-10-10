import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class TripWaitingForPassengerWidget extends StatefulWidget {
  final TripEnroute _tripEnroute;
  final Function _updateState;

  TripWaitingForPassengerWidget(
    this._tripEnroute,
    this._updateState,
  );

  @override
  State<TripWaitingForPassengerWidget> createState() =>
      _TripWaitingForPassengerWidgetState();
}

class _TripWaitingForPassengerWidgetState
    extends State<TripWaitingForPassengerWidget> {
  String _timeString = "";
  int timeInSeconds = 0;
  // late Timer _timer;

  @override
  void initState() {
    final latestItem =
        widget._tripEnroute.items[widget._tripEnroute.items.length - 1];
    final seconds = latestItem != null && latestItem.startTime != null
        ? DateTime.now().difference(latestItem.startTime).inSeconds
        : 0;

    setState(() {
      timeInSeconds = seconds;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeInSeconds++;
        _timeString = Utility.formatHHMMSS(timeInSeconds);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(_timeString),
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
                  widget._tripEnroute.tripId,
                  TripStatus.PassengerOnboarded,
                  Utility.getNextTripDestinationId(widget._tripEnroute),
                  Utility.getNextTripAddressId(widget._tripEnroute),
                  '',
                ),
              )
                  .then((response) {
                widget._updateState();
              });
            },
            child: Text(
              'RESUME TRIP',
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
