class TripEnrouteItem {
  final DateTime start;
  final DateTime end;
  final String title;
  final String location;
  final bool completed;

  TripEnrouteItem(
    this.start,
    this.end,
    this.title,
    this.location,
    this.completed,
  );

  factory TripEnrouteItem.fromJson(dynamic json) => TripEnrouteItem(
        json['start'] != null ? DateTime.parse(json['start']) : null,
        json['end'] != null ? DateTime.parse(json['end']) : null,
        json['title'] as String,
        json['location'] as String,
        json['completed'] as bool,
      );
}
