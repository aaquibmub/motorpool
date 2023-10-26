import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/screens/destinations/add_new_destination_screen.dart';

class AddTripDestinationScreen extends StatefulWidget {
  final String _tripId;
  final int _sequence;

  AddTripDestinationScreen(
    this._tripId,
    this._sequence,
  );

  @override
  State<AddTripDestinationScreen> createState() =>
      _AddTripDestinationScreenState();
}

class _AddTripDestinationScreenState extends State<AddTripDestinationScreen> {
  Widget buildDestinationType(
    BuildContext context,
    String iconPath,
    String title,
    int destinationType,
  ) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNewDestinationScreen(
                    widget._tripId,
                    destinationType,
                    widget._sequence,
                  )),
        )
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          left: 30,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              child: SvgPicture.asset(iconPath),
            ),
            Container(
              child: Text(
                title,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Destination'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 10,
              bottom: 20,
            ),
            child: Text('Select destination'),
          ),
          buildDestinationType(
            context,
            Constants.svgPathAddDropoff,
            'Add pickup location',
            DestinationType.Pickup,
          ),
          buildDestinationType(
            context,
            Constants.svgPathAddDropoff,
            'Add stop location',
            DestinationType.Stop,
          ),
          buildDestinationType(
            context,
            Constants.svgPathAddDropoff,
            'Add dropoff location',
            DestinationType.Dropoff,
          ),
        ],
      ),
    );
  }
}
