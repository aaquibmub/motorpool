import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/providers/auth.dart';
import 'package:motorpool/providers/incident_provider.dart';
import 'package:motorpool/widgets/form/image_input.dart';
import 'package:provider/provider.dart';

import '../../helpers/models/user.dart';
import '../form/form_text_field.dart';

class NewIncidentForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    DropdownItem<String> category,
  ) setCategoryFn;
  final void Function(
    DropdownItem<String> vehical,
  ) setVehicalFn;
  final void Function(
    DropdownItem<String> driver,
  ) setDriverFn;
  final void Function(
    String photo,
  ) setPhotoFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  NewIncidentForm(
    this.formKey,
    this.setCategoryFn,
    this.setVehicalFn,
    this.setDriverFn,
    this.setPhotoFn,
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
  DropdownItem<String> _selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  void _selectedImage(String pickedImage) {
    widget.setPhotoFn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final User _currentuser = Provider.of<Auth>(context).currentUser;

    _vehicalController.text = _currentuser?.vehicals[0]?.text;
    widget.setVehicalFn(_currentuser?.vehicals[0]);

    _driverController.text = _currentuser.firstName;
    widget.setDriverFn(DropdownItem<String>(
      _currentuser.id,
      _currentuser.firstName,
    ));

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
                    value: _selectedCategory?.value,
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
                          _selectedCategory = DropdownItem(
                            value,
                            text,
                          );
                          widget.setCategoryFn(
                            _selectedCategory,
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
              SizedBox(
                height: 30,
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
                  // widget.setModelFn(widget._model);
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
                  // widget.setModelFn(widget._model);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Incident Photo',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ImageInput(
                true,
                _selectedImage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
