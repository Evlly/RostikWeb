// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promocode _$PromocodeFromJson(Map<String, dynamic> json) => Promocode(
      json['id'] as String,
      (json['price'] as num).toDouble(),
      json['code'] as String,
      json['activations'] as int,
      json['count'] as int,
    );

Map<String, dynamic> _$PromocodeToJson(Promocode instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'code': instance.code,
      'activations': instance.activations,
      'count': instance.count,
    };
