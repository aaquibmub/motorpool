import 'package:flutter/material.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/trip_card_widget.dart';
import 'package:provider/provider.dart';

import '../../loading_screen.dart';

class CompletedTripScreen extends StatefulWidget {
  @override
  State<CompletedTripScreen> createState() => _CompletedTripScreenState();
}

class _CompletedTripScreenState extends State<CompletedTripScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateCompletedTrips(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return provider.completedTrips.length > 0
                      ? ListView.builder(
                          itemCount: provider.completedTrips.length,
                          itemBuilder: (_a, i) {
                            return TripCardWidget(
                              provider.completedTrips[i],
                              _updateState,
                            );
                          },
                        )
                      : Center(
                          child: Text("no completed jobs so far"),
                        );
                },
              ),
            );
          }),
    );
  }
}
