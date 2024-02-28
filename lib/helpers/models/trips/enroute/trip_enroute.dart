import 'package:motorpool/helpers/models/trips/enroute/trip_enroute_item.dart';

class TripEnroute {
  final String tripId;
  final int tripType;
  final String tripRoute;
  final String tripDestination;
  final int tripStatus;
  final int numberOfLocations;
  final int numberOfPassengers;
  final List<TripEnrouteItem> items;

  TripEnroute(
    this.tripId,
    this.tripType,
    this.tripRoute,
    this.tripDestination,
    this.tripStatus,
    this.numberOfLocations,
    this.numberOfPassengers,
    this.items,
  );

  factory TripEnroute.fromJson(dynamic json) {
    final List<TripEnrouteItem> items = [];
    final exItems = json['items'] as List<dynamic>;
    if (exItems != null) {
      exItems.forEach((value) {
        TripEnrouteItem prod = TripEnrouteItem.fromJson((value));
        items.add(prod);
      });
    }

    return TripEnroute(
      json['tripId'] as String,
      json['tripType'] as int,
      json['tripRoute'] as String,
      json['tripDestination'] as String,
      json['tripStatus'] as int,
      json['numberOfLocations'] as int,
      json['numberOfPassengers'] as int,
      items,
    );
  }
}
