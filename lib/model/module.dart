
import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';
@JsonSerializable()
class Module {
  String id;
  String name;

  Module(
      this.id,
      this.name
      );

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}