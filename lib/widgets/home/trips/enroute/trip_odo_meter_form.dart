import 'package:flutter/material.dart';

import '../../../form/form_text_field.dart';

class TripOdoMeterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    double meterReading,
  ) setMeterReadingFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  TripOdoMeterForm(
    this.formKey,
    this.setMeterReadingFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<TripOdoMeterForm> createState() => _TripOdoMeterFormState();
}

class _TripOdoMeterFormState extends State<TripOdoMeterForm> {
  final _meterReadingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              FormTextField(
                keyboardType: TextInputType.number,
                fieldLabel: 'Meter Reading',
                hintLabel: 'Type meter reading',
                controller: _meterReadingController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Meter reading is required';
                  }
                  return null;
                },
                onFieldSubmittedFn: (_) {},
                onSaveFn: (value) {
                  widget.setMeterReadingFn(double.parse(value));
                },
                textInputAction: TextInputAction.none,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
