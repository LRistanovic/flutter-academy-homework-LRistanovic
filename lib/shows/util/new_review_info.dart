import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_review_info.g.dart';

@JsonSerializable()
class NewReviewInfo {
  @JsonKey(name: 'show_id')
  int showId;
  String? comment;
  int rating;

  NewReviewInfo(this.showId, this.rating, [this.comment]);

  Map<String, dynamic> toJson() => _$NewReviewInfoToJson(this);
}
