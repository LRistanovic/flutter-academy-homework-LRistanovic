// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_review_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReviewInfo _$NewReviewInfoFromJson(Map<String, dynamic> json) =>
    NewReviewInfo(
      json['show_id'] as int,
      json['rating'] as int,
      json['comment'] as String?,
    );

Map<String, dynamic> _$NewReviewInfoToJson(NewReviewInfo instance) =>
    <String, dynamic>{
      'show_id': instance.showId,
      'comment': instance.comment,
      'rating': instance.rating,
    };
