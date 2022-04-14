import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/util/write_review_provider.dart';

import '../mocks.dart';

void main() {
  test('Request works properly', () async {
    final reviewsProvider = MockReviewsProvider();
    final networkRepository = MockNetworkRepository();
    when(networkRepository.postReview(reviewInfo: anyNamed('reviewInfo')))
        .thenAnswer((_) async => Review(id: 'id', rating: 0, showId: 0, user: User('id', 'email')));

    final writeReviewProvider = WriteReviewProvider(showId: '0', reviewsProvider: reviewsProvider);
    writeReviewProvider.submittedReview(networkRepository);

    expect(writeReviewProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(writeReviewProvider.state is RequestStateSuccess, true);
  });

  test('Reviews get updated', () async {
    final reviewsProvider = MockReviewsProvider();
    final networkRepository = MockNetworkRepository();
    when(networkRepository.postReview(reviewInfo: anyNamed('reviewInfo')))
        .thenAnswer((_) async => Review(id: 'id', rating: 0, showId: 0, user: User('id', 'email')));

    final writeReviewProvider = WriteReviewProvider(showId: '0', reviewsProvider: reviewsProvider);
    await writeReviewProvider.submittedReview(networkRepository);

    verify(reviewsProvider.updateReviews(any, any)).called(1);
  });
}
