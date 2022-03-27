// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RegisterInfoToJson(RegisterInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
    };

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as String?
  ..email = json['email'] as String?
  ..imageUrl = json['image_url'] as String?;
