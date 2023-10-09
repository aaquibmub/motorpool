import 'package:motorpool/helpers/models/common/dropdown_item.dart';

class TripDropoff {
  final String id;
  final int sequence;
  final DropdownItem<String> address;

  TripDropoff(
    this.id,
    this.sequence,
    this.address,
  );

  factory TripDropoff.fromJson(dynamic json) => TripDropoff(
        json['id'] as String,
        json['sequence'] as int,
        DropdownItem<String>.fromJson(json['address']),
      );
}
