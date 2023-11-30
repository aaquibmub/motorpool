import '../../common/dropdown_item.dart';

class VehicalInspectionBodyPartItemModel {
  final String id;
  final DropdownItem<String> part;
  int scraches;
  int dents;
  int damages;
  int index;

  VehicalInspectionBodyPartItemModel(
    this.id,
    this.part,
    this.scraches,
    this.dents,
    this.damages,
    this.index,
  );
  factory VehicalInspectionBodyPartItemModel.fromJson(dynamic json) =>
      VehicalInspectionBodyPartItemModel(
        json['id'] as String,
        DropdownItem<String>.fromJson(json['part']),
        json['scraches'] as int,
        json['dents'] as int,
        json['damages'] as int,
        json['index'] as int,
      );

  Map<String, dynamic> toJson() =>
      vehicalInspectionBodyPartItemModelToJson(this);

  Map<String, dynamic> vehicalInspectionBodyPartItemModelToJson(
          VehicalInspectionBodyPartItemModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'part': {'value': instance.part.value},
        'scraches': instance.scraches,
        'dents': instance.dents,
        'damages': instance.damages,
        'index': instance.index,
      };
}
