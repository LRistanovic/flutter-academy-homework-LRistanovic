import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';

import '../mocks.dart';

void main() {
  test('Fetch reviews in the constructor', () {
    final networkRepository = MockNetworkRepository();
    when(networkRepository.fetchReviews(any)).thenAnswer((_) async => <Review>[]);

    final reviewsProvider = ReviewsProvider('a', networkRepository);

    verify(reviewsProvider.updateReviews('a', networkRepository)).called(1);
  });
}
