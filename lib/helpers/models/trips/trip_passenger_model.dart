import '../common/dropdown_item.dart';

class TripPassengerModel {
  String tripId;
  String passengerName;
  DropdownItem<int> opm;

  TripPassengerModel(
    this.tripId,
    this.passengerName,
    this.opm,
  );
  factory TripPassengerModel.fromJson(dynamic json) => TripPassengerModel(
        json['tripId'] as String,
        json['passengerName'] as String,
        DropdownItem<int>.fromJson(json['opm']),
      );

  Map<String, dynamic> toJson() => tripPassengerModelToJson(this);

  Map<String, dynamic> tripPassengerModelToJson(
    TripPassengerModel instance,
  ) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'passengerName': instance.passengerName,
        'opm': {
          'value': instance.opm.value,
          'text': instance.opm.text,
        },
      };
}
