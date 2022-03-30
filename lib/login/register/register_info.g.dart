// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInfo _$RegisterInfoFromJson(Map<String, dynamic> json) => RegisterInfo(
      email: json['email'] as String?,
      password: json['password'] as String?,
    )..passwordConfirmation = json['passwordConfirmation'] as String?;

Map<String, dynamic> _$RegisterInfoToJson(RegisterInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
    };
