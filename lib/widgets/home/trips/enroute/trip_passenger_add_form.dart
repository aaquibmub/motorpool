import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/models/common/dropdown_item.dart';
import '../../../../providers/trip_provider.dart';
import '../../../form/form_text_field.dart';

class TripPassengerAddForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String passengerName,
  ) setPassengerNameFn;
  final void Function(
    DropdownItem<int> opm,
  ) setOpmFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  TripPassengerAddForm(
    this.formKey,
    this.setPassengerNameFn,
    this.setOpmFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<TripPassengerAddForm> createState() => _TripPassengerAddFormState();
}

class _TripPassengerAddFormState extends State<TripPassengerAddForm> {
  // final _passwordFocusNode = FocusNode();
  final _passengerNameController = TextEditingController();
  DropdownItem<int> _selectedOpm;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TripProvider>(
      context,
      listen: false,
    ).getOpmDropDownList();

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
              // Passenger Name
              FormTextField(
                fieldLabel: 'Passenger Name',
                hintLabel: 'Type passenger name',
                controller: _passengerNameController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setPassengerNameFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              // PTC
              Text(
                'PTC',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: double.infinity,
                child: Consumer<TripProvider>(builder: (ctx, provider, _) {
                  return DropdownButton<int>(
                    isExpanded: true,
                    value: _selectedOpm?.value,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int value) {
                      // This is called when the user selects an item.
                      setState(() {
                        final item = provider.opmList
                            .where((element) => element.value == value)
                            .first;
                        if (item != null) {
                          String text = item.text;
                          _selectedOpm = DropdownItem(
                            value,
                            text,
                          );
                          widget.setOpmFn(
                            _selectedOpm,
                          );
                        }
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return provider.opmList
                          .map<Widget>((DropdownItem<int> item) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          child: Text(
                            item.text,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList();
                    },
                    items: provider.opmList
                        .map<DropdownMenuItem<int>>((DropdownItem<int> value) {
                      return DropdownMenuItem<int>(
                        value: value.value,
                        child: Text(value.text),
                      );
                    }).toList(),
                  );
                }),
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
