import 'package:flutter/material.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../helpers/models/trips/enroute/trip_enroute.dart';
import '../../../../screens/home/tabs_screen.dart';

class TripDoneWidget extends StatelessWidget {
  final TripEnroute _tripEnroute;

  TripDoneWidget(
    this._tripEnroute,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Text(
            'TRIP IS DONE',
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
                // Text(
                //   'TIME ELAPSED',
                //   style: TextStyle(
                //     color: Constants.colorOrange,
                //     fontSize: 14,
                //   ),
                // )
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TabsScreen(1), // TripsScreen
                ),
              );
            },
            child: Text(
              'GO TO HOME',
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
