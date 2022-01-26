// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      json['id'] as String,
      json['module'] as String,
      json['enable'] as bool,
      json['user'] as String,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'id': instance.id,
      'module': instance.module,
      'enable': instance.enable,
      'user': instance.user,
    };
