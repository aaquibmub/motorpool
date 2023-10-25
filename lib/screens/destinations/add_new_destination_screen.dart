import 'package:flutter/material.dart';

import '../../helpers/common/utility.dart';

class AddNewDestinationScreen extends StatefulWidget {
  final String _tripId;
  final int _destinationType;

  AddNewDestinationScreen(
    this._tripId,
    this._destinationType,
  );

  @override
  State<AddNewDestinationScreen> createState() =>
      _AddNewDestinationScreenState();
}

class _AddNewDestinationScreenState extends State<AddNewDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    final destinationTypeText = Utility.getDestinationTypeText(
      widget._destinationType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ' + destinationTypeText),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 10,
            bottom: 20,
          ),
          child: Center(
            child: Text(
              destinationTypeText + ' Location',
            ),
          ),
        ),
      ]),
    );
  }
}
