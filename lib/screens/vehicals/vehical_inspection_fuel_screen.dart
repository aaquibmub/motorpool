import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';

class VehicalInspectionFuelScreen extends StatefulWidget {
  final VehicalInspectionModel _model;

  VehicalInspectionFuelScreen(
    this._model,
  );
  @override
  State<VehicalInspectionFuelScreen> createState() =>
      _VehicalInspectionFuelScreenState();
}

class _VehicalInspectionFuelScreenState
    extends State<VehicalInspectionFuelScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget._model.make),
    );
  }
}
