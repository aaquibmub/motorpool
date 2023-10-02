import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripDropoff {
  final String id;
  final int sequence;
  final DropdownItem<String> dropoffAddress;

  TripDropoff(
    this.id,
    this.sequence,
    this.dropoffAddress,
  );

  factory TripDropoff.fromJson(dynamic json) => TripDropoff(
        json['id'] as String,
        json['sequence'] as int,
        DropdownItem<String>.fromJson(json['dropoffAddress']),
      );
}
