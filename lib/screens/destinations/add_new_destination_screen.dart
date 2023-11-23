import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/address/add_destination_model.dart';
import '../../providers/address_provider.dart';
import '../../widgets/address/add_new_destination_form.dart';
import '../home/trips/enroute/trip_enroute_screen.dart';

class AddNewDestinationScreen extends StatefulWidget {
  final String _tripId;
  final int _destinationType;
  final int _sequence;

  AddNewDestinationScreen(
    this._tripId,
    this._destinationType,
    this._sequence,
  );

  @override
  State<AddNewDestinationScreen> createState() =>
      _AddNewDestinationScreenState();
}

class _AddNewDestinationScreenState extends State<AddNewDestinationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _address;
  void _setAddress(
    String address,
  ) {
    _address = address;
  }

  void _showErrorDialogue(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    if (_address == null) {
      _showErrorDialogue(context, 'Please select address');
      return;
    }

    try {
      var response = await Provider.of<AddressProvider>(
        context,
        listen: false,
      ).addDestination(
        AddDestinationModel(
          widget._tripId,
          widget._destinationType,
          _address,
          widget._sequence,
        ),
      );

      if (response.hasError) {
        _showErrorDialogue(context, response.msg);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TripEnrouteScreen(
                    widget._tripId,
                  )),
        );
      }
    } catch (error) {
      const errorMessage = 'Error';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Widget buildSubmitButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
          Constants.colorGreen,
        )),
        onPressed: () => _submit(context),
        child: Text(
          'ADD DESTINATION',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
      );
    }

    final destinationTypeText = Utility.getDestinationTypeText(
      widget._destinationType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ' + destinationTypeText),
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
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
                            AddNewDestinationForm(
                              _formKey,
                              _setAddress,
                              _submit,
                              context,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          child: buildSubmitButton(),
        )
      ]),
    );
  }
}
