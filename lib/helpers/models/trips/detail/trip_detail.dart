import 'package:motorpool/helpers/models/trips/detail/trip_dropoff.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_pickup.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_special_service.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_stop.dart';
import 'package:motorpool/helpers/models/vehicals/vehical.dart';

class TripDetail {
  final String id;
  final String type;
  final List<TripPickup> pickups;
  final List<TripStop> stops;
  final List<TripStop> addresses;
  final List<TripDropoff> dropoffs;
  final Vehical vehical;
  final List<TripSpecialService> specialServices;
  final String notes;

  TripDetail(
    this.id,
    this.type,
    this.pickups,
    this.stops,
    this.addresses,
    this.dropoffs,
    this.vehical,
    this.specialServices,
    this.notes,
  );

  factory TripDetail.fromJson(dynamic json) {
    final List<TripPickup> pickups = [];
    final exPickups = json['pickups'] as List<dynamic>;
    if (exPickups != null) {
      exPickups.forEach((value) {
        TripPickup prod = TripPickup.fromJson((value));
        pickups.add(prod);
      });
    }

    final List<TripStop> stops = [];
    final exStops = json['stops'] as List<dynamic>;
    if (exStops != null) {
      exStops.forEach((value) {
        TripStop prod = TripStop.fromJson((value));
        stops.add(prod);
      });
    }

    final List<TripStop> addresses = [];
    final exAddresses = json['addresses'] as List<dynamic>;
    if (exAddresses != null) {
      exAddresses.forEach((value) {
        TripStop prod = TripStop.fromJson((value));
        addresses.add(prod);
      });
    }

    final List<TripDropoff> dropoffs = [];
    final exDropoffs = json['dropoffs'] as List<dynamic>;
    if (exDropoffs != null) {
      exDropoffs.forEach((value) {
        TripDropoff prod = TripDropoff.fromJson((value));
        dropoffs.add(prod);
      });
    }
    final List<TripSpecialService> specialServices = [];
    final exSpecialServices = json['specialServices'] as List<dynamic>;
    if (exSpecialServices != null) {
      exSpecialServices.forEach((value) {
        TripSpecialService prod = TripSpecialService.fromJson((value));
        specialServices.add(prod);
      });
    }
    return TripDetail(
      json['id'] as String,
      json['type'] as String,
      pickups,
      stops,
      addresses,
      dropoffs,
      Vehical.fromJson(json['vehical']),
      specialServices,
      json['notes'] as String,
    );
  }

  // Map<String, dynamic> toJson() => _$TripToJson(this);
}
