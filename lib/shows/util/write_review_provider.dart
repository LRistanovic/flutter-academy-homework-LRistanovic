import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';

import 'new_review_info.dart';

class WriteReviewProvider extends RequestProvider {
  String showId;
  int rating = 0;
  String? comment;
  ReviewsProvider reviewsProvider;

  WriteReviewProvider({required this.showId, required this.reviewsProvider});

  Future<void> submittedReview(NetworkRepository networkRepository) async {
    await executeRequest(
      requestBuilder: () {
        return networkRepository.postReview(reviewInfo: NewReviewInfo(int.parse(showId), rating, comment));
      },
    );

    reviewsProvider.updateReviews(showId, networkRepository);
  }
}
