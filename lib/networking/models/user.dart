import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  @JsonKey(name: 'image_url')
  String? imageUrl;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
