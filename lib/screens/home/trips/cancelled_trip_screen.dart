import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/trip_provider.dart';
import '../../../widgets/home/trips/trip_card_widget.dart';
import '../../loading_screen.dart';

class CancelledTripScreen extends StatefulWidget {
  @override
  State<CancelledTripScreen> createState() => _CancelledTripScreenState();
}

class _CancelledTripScreenState extends State<CancelledTripScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateCancelledTrips(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return provider.cancelledTrips.length > 0
                      ? ListView.builder(
                          itemCount: provider.cancelledTrips.length,
                          itemBuilder: (_a, i) {
                            return TripCardWidget(
                              provider.cancelledTrips[i],
                              _updateState,
                            );
                          },
                        )
                      : Center(
                          child: Text("no cancelled so far"),
                        );
                },
              ),
            );
          }),
    );
  }
}
