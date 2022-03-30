import 'package:json_annotation/json_annotation.dart';

part 'register_info.g.dart';

@JsonSerializable()
class RegisterInfo {
  String? email;
  String? password;
  String? passwordConfirmation;

  RegisterInfo({required this.email, required this.password}) {
    passwordConfirmation = password;
  }

  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);
}
