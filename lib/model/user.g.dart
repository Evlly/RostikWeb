// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['role'] as String?,
      json['car'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['balance'] as int?,
      json['first_name'] as String,
      json['last_name'] as String,
      json['middle_name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'car': instance.car,
      'phone': instance.phone,
      'email': instance.email,
      'balance': instance.balance,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'middle_name': instance.middle_name,
    };
