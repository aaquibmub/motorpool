import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class Trip {
  final String id;
  final DropdownItem<int> tripRoute;
  final DropdownItem<int> tripDestination;
  final DropdownItem<int> tripStatus;
  final int numberOfLocations;
  final int numberOfPassenger;
  final String tripId;
  final String pickupTime;
  final String requester;
  final String pickupLocation;

  Trip(
    this.id,
    this.tripRoute,
    this.tripDestination,
    this.tripStatus,
    this.numberOfLocations,
    this.numberOfPassenger,
    this.tripId,
    this.pickupTime,
    this.requester,
    this.pickupLocation,
  );

  factory Trip.fromJson(dynamic json) => Trip(
        json['id'] as String,
        DropdownItem<int>.fromJson(json['tripRoute']),
        DropdownItem<int>.fromJson(json['tripDestination']),
        DropdownItem<int>.fromJson(json['tripStatus']),
        json['numberOfLocations'] as int,
        json['numberOfPassenger'] as int,
        json['tripId'] as String,
        json['pickupTime'] as String,
        json['requester'] as String,
        json['pickupLocation'] as String,
      );

  // Map<String, dynamic> toJson() => _$TripToJson(this);
}
