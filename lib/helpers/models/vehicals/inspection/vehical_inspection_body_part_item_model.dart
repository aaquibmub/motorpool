class VehicalInspectionBodyPartItemModel {
  final String id;
  String sideItemId;
  // final DropdownItem<String> part;
  num xaxis;
  num yaxis;
  int scraches;
  int dents;
  int damages;
  int index;
  String hexColor;
  String image;

  VehicalInspectionBodyPartItemModel(
    this.id,
    this.sideItemId,
    this.xaxis,
    this.yaxis,
    this.scraches,
    this.dents,
    this.damages,
    this.index,
    this.hexColor,
    this.image,
  );
  factory VehicalInspectionBodyPartItemModel.fromJson(dynamic json) =>
      VehicalInspectionBodyPartItemModel(
        json['id'] as String,
        json['sideItemId'] as String,
        // DropdownItem<String>.fromJson(json['part']),
        json['xaxis'] as num,
        json['yaxis'] as num,
        json['scraches'] as int,
        json['dents'] as int,
        json['damages'] as int,
        json['index'] as int,
        json['hexColor'] as String,
        json['image'] as String,
      );

  Map<String, dynamic> toJson() =>
      vehicalInspectionBodyPartItemModelToJson(this);

  Map<String, dynamic> vehicalInspectionBodyPartItemModelToJson(
          VehicalInspectionBodyPartItemModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'sideItemId': instance.sideItemId,
        // 'part': {'value': instance.part.value},
        'xaxis': instance.xaxis,
        'yaxis': instance.yaxis,
        'scraches': instance.scraches,
        'dents': instance.dents,
        'damages': instance.damages,
        'index': instance.index,
        'hexColor': instance.hexColor,
        'image': instance.image,
      };
}
