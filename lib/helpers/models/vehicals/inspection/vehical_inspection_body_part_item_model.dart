import '../../common/dropdown_item.dart';

class VehicalInspectionBodyPartItemModel {
  final String id;
  final DropdownItem<String> part;
  DropdownItem<int> damageLevel;

  VehicalInspectionBodyPartItemModel(
    this.id,
    this.part,
    this.damageLevel,
  );
  factory VehicalInspectionBodyPartItemModel.fromJson(dynamic json) =>
      VehicalInspectionBodyPartItemModel(
        json['id'] as String,
        DropdownItem<String>.fromJson(json['part']),
        DropdownItem<int>.fromJson(json['damageLevel']),
      );

  Map<String, dynamic> toJson() =>
      vehicalInspectionBodyPartItemModelToJson(this);

  Map<String, dynamic> vehicalInspectionBodyPartItemModelToJson(
          VehicalInspectionBodyPartItemModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'part': {'value': instance.part.value},
        'damageLevel': instance.damageLevel != null
            ? {'value': instance.damageLevel.value}
            : null,
      };
}
