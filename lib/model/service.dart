import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  String id;
  String name;
  String price;
  String description;
  String type;
  int popularity;

  Service(
    this.id,
    this.name,
    this.price,
    this.description,
    this.type,
    this.popularity,
  );

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
