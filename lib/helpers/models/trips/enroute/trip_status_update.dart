class TripStatusUpdate {
  final String tripId;
  final int status;
  final String destinationId;
  final String addressId;
  final String remarks;

  TripStatusUpdate(
    this.tripId,
    this.status,
    this.destinationId,
    this.addressId,
    this.remarks,
  );

  Map<String, dynamic> toJson() => tripStatusUpdateToJson(this);

  Map<String, dynamic> tripStatusUpdateToJson(TripStatusUpdate instance) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'status': instance.status.toString(),
        'destinationId': instance.destinationId,
        'addressId': instance.addressId,
        'remarks': instance.remarks,
      };
}
