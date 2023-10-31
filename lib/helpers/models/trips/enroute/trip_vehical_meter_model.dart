class TripVehicalMeterModel {
  String tripId;
  double meterReading;

  TripVehicalMeterModel(
    this.tripId,
    this.meterReading,
  );

  Map<String, dynamic> toJson() => tripVehicalMeterToJson(this);

  Map<String, dynamic> tripVehicalMeterToJson(TripVehicalMeterModel instance) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'meterReading': instance.meterReading,
      };
}
