class TripStatusUpdate {
  final String tripId;
  final int status;
  final String remarks;

  TripStatusUpdate(
    this.tripId,
    this.status,
    this.remarks,
  );

  Map<String, dynamic> toJson() => tripStatusUpdateToJson(this);

  Map<String, dynamic> tripStatusUpdateToJson(TripStatusUpdate instance) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'status': instance.status.toString(),
        'remarks': instance.remarks,
      };
}
