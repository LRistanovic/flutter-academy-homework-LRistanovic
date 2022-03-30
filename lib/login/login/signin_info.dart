import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_info.g.dart';

@JsonSerializable()
class SigninInfo {
  final String email;
  final String password;

  SigninInfo({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$SigninInfoToJson(this);
}
