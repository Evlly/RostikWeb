import 'package:json_annotation/json_annotation.dart';

part 'promocode.g.dart';

@JsonSerializable()
class Promocode {
  String id;
  double price;
  String code;
  int activations;
  int count;

  Promocode(
      this.id,
      this.price,
      this.code,
      this.activations,
      this.count
      );

  factory Promocode.fromJson(Map<String, dynamic> json) => _$PromocodeFromJson(json);

  Map<String, dynamic> toJson() => _$PromocodeToJson(this);
}