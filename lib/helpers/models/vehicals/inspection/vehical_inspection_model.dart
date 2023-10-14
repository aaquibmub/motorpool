import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_item_model.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_general_item_model.dart';

class VehicalInspectionModel {
  final String id;
  final int inspectionId;
  final String inspectionIdStr;
  final DateTime dateTime;
  final String vehicalId;
  final String make;
  final String model;
  final int modelYear;
  final String registrationPlate;
  final List<VehicalInspectionGeneralItemModel> generalInspectionItems;
  final List<VehicalInspectionBodyItemModel> bodyInspectionItems;
  final String bodyInspectionComments;

  final DropdownItem<int> fuelLevel;
  final int odoMeter;

  final bool submitted;

  VehicalInspectionModel(
    this.id,
    this.inspectionId,
    this.inspectionIdStr,
    this.dateTime,
    this.vehicalId,
    this.make,
    this.model,
    this.modelYear,
    this.registrationPlate,
    this.generalInspectionItems,
    this.bodyInspectionItems,
    this.bodyInspectionComments,
    this.fuelLevel,
    this.odoMeter,
    this.submitted,
  );

  factory VehicalInspectionModel.fromJson(dynamic json) {
    final List<VehicalInspectionGeneralItemModel> generalInspectionItems = [];
    final exGeneralInspectionItems =
        json['generalInspectionItems'] as List<dynamic>;
    if (exGeneralInspectionItems != null) {
      exGeneralInspectionItems.forEach((value) {
        VehicalInspectionGeneralItemModel prod =
            VehicalInspectionGeneralItemModel.fromJson((value));
        generalInspectionItems.add(prod);
      });
    }

    final List<VehicalInspectionBodyItemModel> bodyInspectionItems = [];
    final exBodyInspectionItems = json['bodyInspectionItems'] as List<dynamic>;
    if (exBodyInspectionItems != null) {
      exBodyInspectionItems.forEach((value) {
        VehicalInspectionBodyItemModel prod =
            VehicalInspectionBodyItemModel.fromJson((value));
        bodyInspectionItems.add(prod);
      });
    }

    return VehicalInspectionModel(
      json['id'] as String,
      json['inspectionId'] as int,
      json['inspectionIdStr'] as String,
      json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      json['vehicalId'] as String,
      json['make'] as String,
      json['model'] as String,
      json['modelYear'] as int,
      json['registrationPlate'] as String,
      generalInspectionItems,
      bodyInspectionItems,
      json['bodyInspectionComments'] as String,
      DropdownItem<int>.fromJson(json['fuelLevel']),
      json['odoMeter'] as int,
      json['submitted'] as bool,
    );
  }
}
