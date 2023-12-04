class DeallocateVehicalModel {
  final String id;
  int odoMeter;

  DeallocateVehicalModel(
    this.id,
    this.odoMeter,
  );
  factory DeallocateVehicalModel.fromJson(dynamic json) =>
      DeallocateVehicalModel(
        json['id'] as String,
        json['odoMeter'] as int,
      );

  Map<String, dynamic> toJson() => deallocateVehicalModelToJson(this);

  Map<String, dynamic> deallocateVehicalModelToJson(
    DeallocateVehicalModel instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'odoMeter': instance.odoMeter,
      };
}
