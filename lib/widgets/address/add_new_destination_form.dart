import 'package:flutter/material.dart';

import '../form/form_text_field.dart';

class AddNewDestinationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String address,
  ) setAddressFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  AddNewDestinationForm(
    this.formKey,
    this.setAddressFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<AddNewDestinationForm> createState() => _AddNewDestinationFormState();
}

class _AddNewDestinationFormState extends State<AddNewDestinationForm> {
  final _addressController = TextEditingController();
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
              FormTextField(
                fieldLabel: 'Address',
                hintLabel: 'Type address',
                controller: _addressController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  // widget._model.category = value;
                  widget.setAddressFn(value);
                },
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
