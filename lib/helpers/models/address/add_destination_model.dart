class AddDestinationModel {
  final String tripId;
  int destinationType;
  String address;
  int sequence;

  AddDestinationModel(
    this.tripId,
    this.destinationType,
    this.address,
    this.sequence,
  );
  factory AddDestinationModel.fromJson(dynamic json) => AddDestinationModel(
        json['tripId'] as String,
        json['destinationType'] as int,
        json['address'] as String,
        json['sequence'] as int,
      );

  Map<String, dynamic> toJson() => addDestinationModelToJson(this);

  Map<String, dynamic> addDestinationModelToJson(
    AddDestinationModel instance,
  ) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'destinationType': instance.destinationType,
        'address': instance.address,
        'sequence': instance.sequence,
      };
}
