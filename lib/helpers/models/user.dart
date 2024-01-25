import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class User {
  final String id;
  final String firstName;
  final String lastName;
  final List<DropdownItem<String>> vehicals;
  bool onDuty;

  User({
    @required this.id,
    @required this.firstName,
    this.lastName,
    this.vehicals,
    this.onDuty,
  });

  factory User.fromJson(dynamic json) {
    final List<DropdownItem<String>> vehicles = [];
    final exItems = json['vehicals'] as List<dynamic>;
    if (exItems != null) {
      exItems.forEach((value) {
        DropdownItem<String> prod = DropdownItem<String>.fromJson((value));
        vehicles.add(prod);
      });
    }
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      vehicals: vehicles,
      onDuty: json['onDuty'] as bool,
    );
  }
  Map<String, dynamic> toJson() => userToJson(this);

  Map<String, dynamic> userToJson(
    User instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'vehicals': instance.vehicals != null
            ? [
                ...instance.vehicals.map((e) => {
                      'value': e.value,
                      'text': e.text,
                    })
              ]
            : null,
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'onDuty': instance.onDuty,
      };
}
