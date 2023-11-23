import 'package:flutter/material.dart';
import 'package:motorpool/screens/home/trips/enroute/trip_passenger_add_screen.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../providers/trip_provider.dart';
import '../../../loading_screen.dart';

class TripPassengerScreen extends StatefulWidget {
  final String _tripId;
  const TripPassengerScreen(this._tripId, {Key key}) : super(key: key);

  @override
  State<TripPassengerScreen> createState() => _TripPassengerScreenState();
}

class _TripPassengerScreenState extends State<TripPassengerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passengers'),
      ),
      body: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateTripPassengers(widget._tripId),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('Current Passengers'),
                ),
                Expanded(
                  child: Consumer<TripProvider>(
                    builder: (ctx, provider, _) {
                      return provider.tripPassengers.length > 0
                          ? Column(
                              children: [
                                ...provider.tripPassengers
                                    .map(
                                      (e) => Container(
                                        width: double.infinity,
                                        height: 50,
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          e.name,
                                        ),
                                      ),
                                    )
                                    .toList()
                              ],
                            )
                          : Center(
                              child: Text("no passengers"),
                            );
                    },
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripPassengerAddScreen(
                                  widget._tripId,
                                )),
                      );
                    },
                    child: Text(
                      'Add Passenger',
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                    // elevation: 0,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            );
          }),
    );
  }
}
