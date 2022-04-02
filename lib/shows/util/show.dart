import 'package:freezed_annotation/freezed_annotation.dart';

part 'show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Show {
  final String id;
  @JsonKey(name: 'title')
  final String? name;
  final String? description;
  @JsonKey(name: 'no_of_reviews')
  final int? numOfReviews;
  final double? averageRating;
  final String? imageUrl;

  Show(this.id, this.name, this.description, this.numOfReviews, this.averageRating, this.imageUrl);

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
}
