import 'package:flutter/material.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/screens/home/trips/enroute/trip_enroute_screen.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common/utility.dart';
import '../../../../helpers/models/common/dropdown_item.dart';
import '../../../../helpers/models/trips/trip_passenger_model.dart';
import '../../../../widgets/home/trips/enroute/trip_passenger_add_form.dart';
import '../../../loading_screen.dart';

class TripPassengerAddScreen extends StatefulWidget {
  final String _tripId;
  const TripPassengerAddScreen(this._tripId, {Key key}) : super(key: key);

  @override
  State<TripPassengerAddScreen> createState() => _TripPassengerAddScreenState();
}

class _TripPassengerAddScreenState extends State<TripPassengerAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  String _passengerName;
  DropdownItem<int> _opm;

  void _setPassengerName(
    String passengerName,
  ) {
    _passengerName = passengerName;
  }

  void _setOpm(
    DropdownItem<int> opm,
  ) {
    _opm = opm;
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
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await Provider.of<TripProvider>(
        context,
        listen: false,
      ).addPassenger(
        TripPassengerModel(
          widget._tripId,
          _passengerName,
          _opm,
        ),
      );

      setState(() {
        _isLoading = false;
      });

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
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Unable to add';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildAddButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          'ADD PASSENGER',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Passenger'),
      ),
      body: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Center(
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
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
                                  child: Text(
                                    'Enter Passenger Details',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TripPassengerAddForm(
                                  _formKey,
                                  _setPassengerName,
                                  _setOpm,
                                  _submit,
                                  context,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      !Utility.isPhone(deviceSize)
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.end,
                                  children: [
                                    if (!Utility.isPhone(deviceSize))
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        alignment: Alignment.topRight,
                                        child: buildAddButton(),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (Utility.isPhone(deviceSize))
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: buildAddButton(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
