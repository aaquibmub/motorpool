import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:provider/provider.dart';

class VehicalInspectionGeneralScreen extends StatefulWidget {
  final VehicalInspectionModel _model;
  // final Function _updateState;

  VehicalInspectionGeneralScreen(
    this._model,
    // this._updateState,
  );
  @override
  State<VehicalInspectionGeneralScreen> createState() =>
      _VehicalInspectionGeneralScreenState();
}

class _VehicalInspectionGeneralScreenState
    extends State<VehicalInspectionGeneralScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                        child: Text('VEHICAL'),
                      ),
                      Center(
                        child: Text(
                          widget._model.make +
                              ' ' +
                              widget._model.model +
                              ' ' +
                              widget._model.modelYear.toString(),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget._model.registrationPlate,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...widget._model.generalInspectionItems.map((m) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(),
                                        child:
                                            Image.memory(base64Decode(m.image)),
                                      ),
                                      Text(
                                        m.option.text,
                                      )
                                    ],
                                  ),
                                  Switch(
                                    // This bool value toggles the switch.
                                    value: m.answer,
                                    activeColor: Colors.red,
                                    onChanged: (bool value) {
                                      setState(() {
                                        m.answer = value;
                                      });
                                      Provider.of<VehicalProvider>(context,
                                              listen: false)
                                          .saveGeneralInspectionItem(m)
                                          .then((response) {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
