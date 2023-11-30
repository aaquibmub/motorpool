import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_side_item_model.dart';
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
  List<VehicalInspectionBodySideItemModel> bodyInspectionItems;
  String bodyInspectionComments;

  num fuelLevel;
  int odoMeter;

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

    final List<VehicalInspectionBodySideItemModel> bodyInspectionItems = [];
    final exBodyInspectionItems = json['bodyInspectionItems'] as List<dynamic>;
    if (exBodyInspectionItems != null) {
      exBodyInspectionItems.forEach((value) {
        VehicalInspectionBodySideItemModel prod =
            VehicalInspectionBodySideItemModel.fromJson((value));
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
      json['fuelLevel'] as num,
      json['odoMeter'] as int,
    );
  }

  Map<String, dynamic> toJson() => vehicalInspectionModelToJson(this);

  Map<String, dynamic> vehicalInspectionModelToJson(
          VehicalInspectionModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'fuelLevel': instance.fuelLevel,
        'odoMeter': instance.odoMeter,
      };
}
