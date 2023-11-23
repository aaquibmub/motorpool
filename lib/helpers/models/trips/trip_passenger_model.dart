import '../common/dropdown_item.dart';

class TripPassengerModel {
  String tripId;
  String passengerName;
  DropdownItem<String> ageGroup;
  DropdownItem<String> nationality;
  String mobileNumber;
  DropdownItem<int> opm;

  TripPassengerModel(
    this.tripId,
    this.passengerName,
    this.ageGroup,
    this.nationality,
    this.mobileNumber,
    this.opm,
  );
  factory TripPassengerModel.fromJson(dynamic json) => TripPassengerModel(
        json['tripId'] as String,
        json['passengerName'] as String,
        DropdownItem<String>.fromJson(json['ageGroup']),
        DropdownItem<String>.fromJson(json['nationality']),
        json['mobileNumber'] as String,
        DropdownItem<int>.fromJson(json['opm']),
      );

  Map<String, dynamic> toJson() => tripPassengerModelToJson(this);

  Map<String, dynamic> tripPassengerModelToJson(
    TripPassengerModel instance,
  ) =>
      <String, dynamic>{
        'tripId': instance.tripId,
        'passengerName': instance.passengerName,
        'ageGroup': {
          'value': instance.ageGroup.value,
          'text': instance.ageGroup.text,
        },
        'nationality': {
          'value': instance.nationality.value,
          'text': instance.nationality.text,
        },
        'mobileNumber': instance.mobileNumber,
        'opm': {
          'value': instance.opm.value,
          'text': instance.opm.text,
        },
      };
}
