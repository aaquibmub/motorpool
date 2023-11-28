import 'package:flutter/material.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/trip_card_widget.dart';
import 'package:provider/provider.dart';

import '../../loading_screen.dart';

class UpcomingTripScreen extends StatefulWidget {
  @override
  State<UpcomingTripScreen> createState() => _UpcomingTripScreenState();
}

class _UpcomingTripScreenState extends State<UpcomingTripScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateUpcomingTrips(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return provider.upcomingTrips.length > 0
                      ? ListView.builder(
                          itemCount: provider.upcomingTrips.length,
                          itemBuilder: (_a, i) {
                            return TripCardWidget(
                              provider.upcomingTrips[i],
                              _updateState,
                            );
                          },
                        )
                      : Center(
                          child: Text("no upcoming jobs so far"),
                        );
                },
              ),
            );
          }),
    );
  }
}
