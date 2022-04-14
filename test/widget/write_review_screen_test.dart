import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/shows/write_review_screen.dart';

import '../mocks.dart';

void main() {
  testWidgets('Write review screen built properly', (WidgetTester tester) async {
    final networkRepository = MockNetworkRepository();
    final reviewsProvider = MockReviewsProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: WriteReviewScreen(
              reviewsProvider: reviewsProvider,
              showId: '3',
            ),
          ),
        ),
      ),
    );

    final textFinder = find.text('Write a review');
    final ratingFinder = find.byType(RatingBar);
    final textFieldFinder = find.byType(TextField);
    final buttonFinder = find.byType(ElevatedButton);

    expect(textFinder, findsOneWidget);
    expect(ratingFinder, findsOneWidget);
    expect(textFieldFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
