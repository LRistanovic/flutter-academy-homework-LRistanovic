import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/widgets/review_widget.dart';

void main() {
  testWidgets('Review widget golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReviewWidget(
            review: Review(
              id: 'id',
              user: User('user id', 'email'),
              showId: 0,
              rating: 4,
              comment: 'review comment',
            ),
          ),
        ),
      ),
    );

    await expectLater(find.byType(ReviewWidget), matchesGoldenFile('review_widget.png'));
  });
}
