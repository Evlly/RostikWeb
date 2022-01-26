// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      json['id'] as String,
      User.fromJson(json['staff'] as Map<String, dynamic>),
      User.fromJson(json['client'] as Map<String, dynamic>),
      (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['start_date'] as String,
      json['end_date'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'staff': instance.staff,
      'client': instance.client,
      'services': instance.services,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'status': instance.status,
    };
