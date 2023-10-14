import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class VehicalInspectionBodyItemModel {
  final String id;
  final DropdownItem<String> side;
  final DropdownItem<String> part;
  final DropdownItem<int> damageLevel;

  VehicalInspectionBodyItemModel(
    this.id,
    this.side,
    this.part,
    this.damageLevel,
  );

  factory VehicalInspectionBodyItemModel.fromJson(dynamic json) =>
      VehicalInspectionBodyItemModel(
        json['id'] as String,
        DropdownItem<String>.fromJson(json['side']),
        DropdownItem<String>.fromJson(json['part']),
        DropdownItem<int>.fromJson(json['damageLevel']),
      );
}
