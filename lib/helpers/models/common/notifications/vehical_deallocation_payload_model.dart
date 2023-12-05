class VehicalDeallocationPayloadModel {
  final String Vehical;
  final String DeallocationId;

  VehicalDeallocationPayloadModel(
    this.Vehical,
    this.DeallocationId,
  );

  factory VehicalDeallocationPayloadModel.fromJson(dynamic json) =>
      VehicalDeallocationPayloadModel(
        json != null ? json['Vehical'] as String : null,
        json != null ? json['DeallocationId'] as String : null,
      );
}
