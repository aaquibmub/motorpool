import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripStop {
  final String id;
  final int sequence;
  final DropdownItem<String> address;

  TripStop(
    this.id,
    this.sequence,
    this.address,
  );

  factory TripStop.fromJson(dynamic json) => TripStop(
        json['id'] as String,
        json['sequence'] as int,
        DropdownItem<String>.fromJson(json['address']),
      );
}
