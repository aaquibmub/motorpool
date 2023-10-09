import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripPickup {
  final String id;
  final int sequence;
  final DropdownItem<String> address;

  TripPickup(
    this.id,
    this.sequence,
    this.address,
  );

  factory TripPickup.fromJson(dynamic json) => TripPickup(
        json['id'] as String,
        json['sequence'] as int,
        DropdownItem<String>.fromJson(json['address']),
      );
}
