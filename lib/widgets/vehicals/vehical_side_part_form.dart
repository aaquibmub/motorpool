import 'package:flutter/material.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_part_item_model.dart';

class VehicalSidePartFrom extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  // final VehicalInspectionBodyPartItemModel _model;
  final void Function(
    VehicalInspectionBodyPartItemModel model,
  ) setModelFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  VehicalSidePartFrom(
    this.formKey,
    // this._model,
    this.setModelFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<VehicalSidePartFrom> createState() => _VehicalSidePartFromState();
}

class _VehicalSidePartFromState extends State<VehicalSidePartFrom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: widget.formKey,
        child: null,
      ),
    );
  }
}
