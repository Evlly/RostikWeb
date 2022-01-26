import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String? role;
  String? car;
  String? phone;
  String? email;
  int? balance;
  String first_name;
  String last_name;
  String middle_name;

  User(
    this.id,
    this.role,
    this.car,
    this.phone,
    this.email,
    this.balance,
    this.first_name,
    this.last_name,
    this.middle_name,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
