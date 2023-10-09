import 'package:motorpool/helpers/models/trips/detail/trip_dropoff.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_pickup.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_stop.dart';
import 'package:motorpool/helpers/models/vehicals/vehical.dart';

class TripDetail {
  final String id;
  final List<TripPickup> pickups;
  final List<TripStop> stops;
  final List<TripDropoff> dropoffs;
  final Vehical vehical;

  TripDetail(
    this.id,
    this.pickups,
    this.stops,
    this.dropoffs,
    this.vehical,
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

    final List<TripDropoff> dropoffs = [];
    final exDropoffs = json['dropoffs'] as List<dynamic>;
    if (exDropoffs != null) {
      exDropoffs.forEach((value) {
        TripDropoff prod = TripDropoff.fromJson((value));
        dropoffs.add(prod);
      });
    }
    return TripDetail(
      json['id'] as String,
      pickups,
      stops,
      dropoffs,
      Vehical.fromJson(json['vehical']),
    );
  }

  // Map<String, dynamic> toJson() => _$TripToJson(this);
}
