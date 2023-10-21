import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class IncidentModel {
  final String id;
  DropdownItem<String> category;
  DropdownItem<String> driver;
  DropdownItem<String> vehical;
  String photo;
  String remarks;

  IncidentModel(
    this.id,
    this.category,
    this.vehical,
    this.driver,
    this.photo,
    this.remarks,
  );
  factory IncidentModel.fromJson(dynamic json) => IncidentModel(
        json['id'] as String,
        DropdownItem<String>.fromJson(json['category']),
        DropdownItem<String>.fromJson(json['vehical']),
        DropdownItem<String>.fromJson(json['driver']),
        json['photo'] as String,
        json['remarks'] as String,
      );

  Map<String, dynamic> toJson() => incidentModelToJson(this);

  Map<String, dynamic> incidentModelToJson(
    IncidentModel instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'category': {
          'value': instance.category.value,
          'text': instance.category.text,
        },
        'vehical': {
          'value': instance.vehical.value,
          'text': instance.vehical.text,
        },
        'driver': {
          'value': instance.driver.value,
          'text': instance.driver.text,
        },
        'photo': instance.photo,
        'remarks': instance.remarks,
      };
}
