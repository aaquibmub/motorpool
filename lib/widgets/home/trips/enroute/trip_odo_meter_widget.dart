import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_odo_meter_form.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../helpers/models/trips/enroute/trip_enroute.dart';
import '../../../../helpers/models/trips/enroute/trip_vehical_meter_model.dart';
import '../../../../providers/trip_provider.dart';
import '../../../../screens/home/trips/enroute/trip_enroute_screen.dart';

class TripOdoMeterWidget extends StatefulWidget {
  final TripEnroute _tripEnroute;
  final int _tripStatus;
  final int _tripNextStatus;

  TripOdoMeterWidget(
    this._tripEnroute,
    this._tripStatus,
    this._tripNextStatus,
  );

  @override
  State<TripOdoMeterWidget> createState() => _TripOdoMeterWidgetState();
}

class _TripOdoMeterWidgetState extends State<TripOdoMeterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  double _meterReading;
  void _setMeterReading(
    double meterReading,
  ) {
    _meterReading = meterReading;
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

    if (_meterReading == null) {
      _showErrorDialogue(context, 'Please input meter reading');
      return;
    }

    try {
      var response = await Provider.of<TripProvider>(
        context,
        listen: false,
      ).updateTripVehicalMeter(
        TripVehicalMeterModel(
          widget._tripEnroute.tripId,
          _meterReading,
          widget._tripStatus,
        ),
      );

      if (response.hasError) {
        _showErrorDialogue(context, response.msg);
      } else {
        Provider.of<TripProvider>(context, listen: false)
            .updateStatus(
          TripStatusUpdate(
            widget._tripEnroute.tripId,
            widget._tripNextStatus,
            null,
            null,
            '',
          ),
        )
            .then((response) {
          if (response.hasError) {
            _showErrorDialogue(context, response.msg);
            return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TripEnrouteScreen(
                      widget._tripEnroute.tripId,
                    )),
          );
        });
      }
    } catch (error) {
      const errorMessage = 'Error';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSubmitButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
          Constants.colorGreen,
        )),
        onPressed: () => _submit(context),
        child: Text(
          // widget._tripNextStatus == TripStatus.OdoMeterAtEnd ||
          //         widget._tripNextStatus == TripStatus.OdoMeterAtCancel
          //     ? 'COMPLETE TRIP'
          //     :
          'START',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: TripOdoMeterForm(
            _formKey,
            _setMeterReading,
            _submit,
            context,
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          child: buildSubmitButton(),
        )
      ],
    );
  }
}
