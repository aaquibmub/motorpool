import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_part_item_model.dart';

class VehicalInspectionBodySideItemModel {
  final String id;
  final DropdownItem<String> side;
  List<VehicalInspectionBodyPartItemModel> parts;

  VehicalInspectionBodySideItemModel(
    this.id,
    this.side,
    this.parts,
  );

  factory VehicalInspectionBodySideItemModel.fromJson(dynamic json) {
    final List<VehicalInspectionBodyPartItemModel> parts = [];
    final exParts = json['parts'] as List<dynamic>;
    if (exParts != null) {
      exParts.forEach((value) {
        VehicalInspectionBodyPartItemModel prod =
            VehicalInspectionBodyPartItemModel.fromJson((value));
        parts.add(prod);
      });
    }
    return VehicalInspectionBodySideItemModel(
      json['id'] as String,
      DropdownItem<String>.fromJson(json['side']),
      parts,
    );
  }
}
