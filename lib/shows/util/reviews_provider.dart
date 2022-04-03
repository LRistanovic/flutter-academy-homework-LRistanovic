import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class ReviewsProvider extends RequestProvider {
  // List<Review>? reviews;
  String showId;

  ReviewsProvider(this.showId, BuildContext context) {
    updateReviews(showId, context);
  }

  void updateReviews(String showId, BuildContext context) {
    executeRequest(
      requestBuilder: () {
        return context.read<NetworkRepository>().fetchReviews(showId);
      },
    );
  }
}
