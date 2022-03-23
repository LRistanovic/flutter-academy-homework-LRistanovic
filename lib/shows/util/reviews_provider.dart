import 'package:flutter/material.dart';

import 'review.dart';

class ReviewsProvider with ChangeNotifier {
  List<Review> reviews = Review.allReviews;
}
