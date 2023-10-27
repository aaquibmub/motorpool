import 'package:flutter/material.dart';
import 'package:motorpool/screens/home/trips/cancelled_trip_screen.dart';
import 'package:motorpool/screens/home/trips/completed_trip_screen.dart';
import 'package:motorpool/screens/home/trips/upcoming_trip_screen.dart';

import '../../helpers/common/utility.dart';

class TripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // initialIndex: 0,
      child: Scaffold(
        drawer: Utility.buildDrawer(context),
        appBar: AppBar(
          title: Text(
            'Trips',
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'UPCOMING JOB',
              ),
              Tab(
                text: 'COMPLETED',
              ),
              Tab(
                text: 'CANCELLED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            UpcomingTripScreen(),
            CompletedTripScreen(),
            CancelledTripScreen()
          ],
        ),
      ),
    );
  }
}
