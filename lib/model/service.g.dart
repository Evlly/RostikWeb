// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      json['id'] as String,
      json['name'] as String,
      json['price'] as String,
      json['description'] as String,
      json['type'] as String,
      json['popularity'] as int,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'type': instance.type,
      'popularity': instance.popularity,
    };
