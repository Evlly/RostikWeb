import 'package:json_annotation/json_annotation.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';

part 'contract.g.dart';

@JsonSerializable()
class Contract {
  String id;
  User? staff;
  User client;
  List<Service> services;
  String start_date;
  String end_date;
  String status;

  Contract(this.id, this.staff, this.client, this.services, this.start_date,
      this.end_date, this.status);

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);

  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
