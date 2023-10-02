import 'package:motorpool/helpers/models/trips/enroute/trip_enroute_item.dart';

class TripEnroute {
  final String tripId;
  final String tripRoute;
  final String tripDestination;
  final int numberOfLocations;
  final int numberOfPassengers;
  final List<TripEnrouteItem> items;

  TripEnroute(
    this.tripId,
    this.tripRoute,
    this.tripDestination,
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
      json['tripRoute'] as String,
      json['tripDestination'] as String,
      json['numberOfLocations'] as int,
      json['numberOfPassengers'] as int,
      items,
    );
  }
}
