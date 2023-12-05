import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class User {
  final String id;
  final String firstName;
  final String lastName;
  final DropdownItem<String> vehical;
  bool onDuty;

  User({
    @required this.id,
    @required this.firstName,
    this.lastName,
    this.vehical,
    this.onDuty,
  });

  factory User.fromJson(dynamic json) => User(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        vehical: DropdownItem<String>.fromJson(json['vehical']),
        onDuty: json['onDuty'] as bool,
      );
  Map<String, dynamic> toJson() => userToJson(this);

  Map<String, dynamic> userToJson(
    User instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'vehical': instance.vehical != null
            ? {
                'value': instance.vehical.value,
                'text': instance.vehical.text,
              }
            : null,
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'onDuty': instance.onDuty,
      };
}
