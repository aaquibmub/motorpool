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
    DropdownItem<String> ageGroup,
  ) setAgeGroupFn;
  final void Function(
    DropdownItem<String> nationality,
  ) setNationalityFn;
  final void Function(
    String mobileNumber,
  ) setMobileNumberFn;
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
    this.setAgeGroupFn,
    this.setNationalityFn,
    this.setMobileNumberFn,
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
  DropdownItem<String> _selectedAgeGroup;
  DropdownItem<String> _selectedNationality;
  final _mobileNumberController = TextEditingController();
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
    ).getAgrGroupDropDownList();
    Provider.of<TripProvider>(
      context,
      listen: false,
    ).getNationalityDropDownList();
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
              Text(
                'Age Group',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: double.infinity,
                child: Consumer<TripProvider>(builder: (ctx, provider, _) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedAgeGroup?.value,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        final item = provider.ageGroupList
                            .where((element) => element.value == value)
                            .first;
                        if (item != null) {
                          String text = item.text;
                          _selectedAgeGroup = DropdownItem(
                            value,
                            text,
                          );
                          widget.setAgeGroupFn(
                            _selectedAgeGroup,
                          );
                        }
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return provider.ageGroupList
                          .map<Widget>((DropdownItem<String> item) {
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
                    items: provider.ageGroupList.map<DropdownMenuItem<String>>(
                        (DropdownItem<String> value) {
                      return DropdownMenuItem<String>(
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
              Text(
                'Nationality',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: double.infinity,
                child: Consumer<TripProvider>(builder: (ctx, provider, _) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedNationality?.value,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        final item = provider.nationalityList
                            .where((element) => element.value == value)
                            .first;
                        if (item != null) {
                          String text = item.text;
                          _selectedNationality = DropdownItem(
                            value,
                            text,
                          );
                          widget.setNationalityFn(
                            _selectedNationality,
                          );
                        }
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return provider.nationalityList
                          .map<Widget>((DropdownItem<String> item) {
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
                    items: provider.nationalityList
                        .map<DropdownMenuItem<String>>(
                            (DropdownItem<String> value) {
                      return DropdownMenuItem<String>(
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
              FormTextField(
                fieldLabel: 'Mobile Number',
                hintLabel: 'Type mobile number',
                controller: _mobileNumberController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Mobile number is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setMobileNumberFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'OPM',
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
