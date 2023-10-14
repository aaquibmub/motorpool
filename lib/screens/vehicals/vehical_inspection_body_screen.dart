import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';

class VehicalInspectionBodyScreen extends StatefulWidget {
  final VehicalInspectionModel _model;

  VehicalInspectionBodyScreen(
    this._model,
  );
  @override
  State<VehicalInspectionBodyScreen> createState() =>
      _VehicalInspectionBodyScreenState();
}

class _VehicalInspectionBodyScreenState
    extends State<VehicalInspectionBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget._model.make),
    );
  }
}
