import 'package:tv_shows/networking/request_provider/request_provider.dart';

import '../../networking/network_repository.dart';

class ReviewsProvider extends RequestProvider {
  String showId;

  ReviewsProvider(this.showId, NetworkRepository networkRepository) {
    updateReviews(showId, networkRepository);
  }

  void updateReviews(String showId, NetworkRepository networkRepository) {
    executeRequest(
      requestBuilder: () {
        return networkRepository.fetchReviews(showId);
      },
    );
  }
}
