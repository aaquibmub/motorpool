import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/incidents/incident_model.dart';
import 'package:motorpool/providers/auth.dart';
import 'package:motorpool/providers/incident_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/models/user.dart';
import '../form/form_text_field.dart';

class NewIncidentForm extends StatefulWidget {
  IncidentModel _model;
  final GlobalKey<FormState> formKey;
  final void Function(
    IncidentModel model,
  ) setModelFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  NewIncidentForm(
    this.formKey,
    this.setModelFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<NewIncidentForm> createState() => _NewIncidentFormState();
}

class _NewIncidentFormState extends State<NewIncidentForm> {
  // final _passwordFocusNode = FocusNode();
  final _vehicalController = TextEditingController();
  final _driverController = TextEditingController();

  @override
  void initState() {
    widget._model = IncidentModel(
      '',
      null,
      null,
      null,
      '',
      '',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User _currentuser = Provider.of<Auth>(context).currentUser;

    widget._model.vehical = _currentuser?.vehical;
    _vehicalController.text = _currentuser?.vehical?.text;

    widget._model.driver = DropdownItem<String>(
      _currentuser.id,
      _currentuser.firstName,
    );
    _driverController.text = widget._model.driver.text;

    Provider.of<IncidentProvider>(
      context,
      listen: false,
    ).getCategoryDropDownList();

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
              Text(
                'Incident Category',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: double.infinity,
                child: Consumer<IncidentProvider>(builder: (ctx, provider, _) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: widget._model?.category?.value,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        final item = provider.categoryList
                            .where((element) => element.value == value)
                            .first;
                        if (item != null) {
                          String text = item.text;
                          widget._model.category = DropdownItem(
                            value,
                            text,
                          );
                        }
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return provider.categoryList
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
                    items: provider.categoryList.map<DropdownMenuItem<String>>(
                        (DropdownItem<String> value) {
                      return DropdownMenuItem<String>(
                        value: value.value,
                        child: Text(value.text),
                      );
                    }).toList(),
                  );
                }),
              ),
              FormTextField(
                readonly: true,
                fieldLabel: 'Vehical',
                hintLabel: 'Type user name',
                controller: _vehicalController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Vehical is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  // widget._model.category = value;
                  widget.setModelFn(widget._model);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                readonly: true,
                fieldLabel: 'Driver',
                hintLabel: 'Type user name',
                controller: _driverController,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Vehical is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  // widget._model.category = value;
                  widget.setModelFn(widget._model);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
