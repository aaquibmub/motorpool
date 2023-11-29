import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class VehicalInspectionGeneralItemModel {
  final String id;
  final DropdownItem<String> option;
  final String image;
  bool answer;

  VehicalInspectionGeneralItemModel(
    this.id,
    this.option,
    this.image,
    this.answer,
  );

  factory VehicalInspectionGeneralItemModel.fromJson(dynamic json) =>
      VehicalInspectionGeneralItemModel(
        json['id'] as String,
        DropdownItem<String>.fromJson(json['option']),
        json['image'] as String,
        json['answer'] as bool,
      );

  Map<String, dynamic> toJson() =>
      vehicalInspectionGeneralItemModelToJson(this);

  Map<String, dynamic> vehicalInspectionGeneralItemModelToJson(
          VehicalInspectionGeneralItemModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'option': {'value': instance.option.value},
        'image': instance.image,
        'answer': instance.answer,
      };
}
