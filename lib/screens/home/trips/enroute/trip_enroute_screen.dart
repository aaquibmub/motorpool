import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_enroute_widget.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_waiting_for_passsenger_widget.dart';
import 'package:provider/provider.dart';

import '../../../loading_screen.dart';

class TripEnrouteScreen extends StatefulWidget {
  final String _id;

  TripEnrouteScreen(
    this._id,
  );
  @override
  State<TripEnrouteScreen> createState() => _TripEnrouteScreenState();
}

class _TripEnrouteScreenState extends State<TripEnrouteScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Enroute'),
      ),
      body: FutureBuilder(
          future: Provider.of<TripProvider>(
            context,
            listen: false,
          ).populateTripEnroute(widget._id),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return provider.tripEnroute.tripStatus !=
                          TripStatus.ArrivedAtPickupLocation
                      ? TripEnrouteWidget(
                          provider.tripEnroute,
                          _updateState,
                        )
                      : TripWaitingForPassengerWidget(
                          provider.tripEnroute,
                          _updateState,
                        );
                },
              ),
            );
          }),
    );
  }
}
