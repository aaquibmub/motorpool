import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripEnrouteItem {
  final DateTime startTime;
  final String start;
  final DateTime endTime;
  final String end;
  final String title;
  final String destinationId;
  final DropdownItem<int> destinationType;
  final DropdownItem<String> location;
  final int sequence;
  final bool completed;

  TripEnrouteItem(
    this.startTime,
    this.start,
    this.endTime,
    this.end,
    this.title,
    this.destinationId,
    this.destinationType,
    this.location,
    this.sequence,
    this.completed,
  );

  factory TripEnrouteItem.fromJson(dynamic json) => TripEnrouteItem(
        json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
        // json['end'] != null ? DateTime.parse(json['end']) : null,
        json['start'] as String,
        json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
        json['end'] as String,
        json['title'] as String,
        json['destinationId'] as String,
        DropdownItem<int>.fromJson(json['destinationType']),
        DropdownItem<String>.fromJson(json['location']),
        json['sequence'] as int,
        json['completed'] as bool,
      );
}
