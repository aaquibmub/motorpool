import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripEnrouteItem {
  final String start;
  final String end;
  final String title;
  final DropdownItem<String> location;
  final bool completed;

  TripEnrouteItem(
    this.start,
    this.end,
    this.title,
    this.location,
    this.completed,
  );

  factory TripEnrouteItem.fromJson(dynamic json) => TripEnrouteItem(
        // json['start'] != null ? DateTime.parse(json['start']) : null,
        // json['end'] != null ? DateTime.parse(json['end']) : null,
        json['start'] as String,
        json['end'] as String,
        json['title'] as String,
        DropdownItem<String>.fromJson(json['location']),
        json['completed'] as bool,
      );
}
