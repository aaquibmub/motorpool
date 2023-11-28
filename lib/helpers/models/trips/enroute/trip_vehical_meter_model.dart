class TripVehicalMeterModel {
  String tripId;
  double meterReading;
  int status;

  TripVehicalMeterModel(
    this.tripId,
    this.meterReading,
    this.status,
  );

  Map<String, dynamic> toJson() => tripVehicalMeterToJson(this);

  Map<String, dynamic> tripVehicalMeterToJson(TripVehicalMeterModel instance) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'meterReading': instance.meterReading,
        'status': instance.status,
      };
}
