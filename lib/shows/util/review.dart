import 'package:json_annotation/json_annotation.dart';
import 'package:tv_shows/networking/models/user.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  String id;

  String? comment;
  int rating;
  @JsonKey(name: 'show_id')
  int showId;
  User user;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review({required this.id, this.comment, required this.rating, required this.showId, required this.user});
}
