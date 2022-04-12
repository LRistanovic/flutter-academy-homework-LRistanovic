import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/shows/show_details_screen_slivers.dart';
import 'package:tv_shows/shows/util/review.dart';
import 'package:tv_shows/shows/util/show.dart';
import 'package:tv_shows/shows/widgets/review_widget.dart';
import 'package:tv_shows/shows/write_review_screen.dart';

import '../mocks.dart';

void main() {
  testWidgets('Shows are properly showing', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      when(networkRepository.fetchReviews(any)).thenAnswer(
        (_) async => [
          Review(
            id: 'id',
            rating: 3,
            showId: 0,
            user: User('id', 'email'),
          )
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: ShowDetailsScreen(show: Show('id', 'name', 'description', 0, 0, null)),
          ),
        ),
      );

      var showFinder = find.byType(ReviewWidget);
      expect(showFinder, findsNothing);
      await tester.pump();
      showFinder = find.byType(ReviewWidget);
      expect(showFinder, findsWidgets);
    });
  });

  testWidgets('Loading and loading animation work start immediately', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      when(networkRepository.fetchReviews(any)).thenAnswer(
        (_) async => [
          Review(
            id: 'id',
            rating: 3,
            showId: 0,
            user: User('id', 'email'),
          )
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: ShowDetailsScreen(show: Show('id', 'name', 'description', 0, 0, null)),
          ),
        ),
      );

      final lottieFinder = find.byType(Lottie);

      expect(lottieFinder, findsWidgets);
      await tester.pump();
      expect(lottieFinder, findsNothing);
    });
  });

  testWidgets('Write review button works', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      when(networkRepository.fetchReviews(any)).thenAnswer(
        (_) async => [
          Review(
            id: '1',
            rating: 3,
            showId: 0,
            user: User('id', 'email'),
          )
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: ShowDetailsScreen(show: Show('id', 'name', 'description', 0, 0, null)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final buttonFinder = find.byType(ElevatedButton);

      await tester.dragUntilVisible(buttonFinder, find.byType(CustomScrollView), const Offset(0, -50));
      await tester.pump();
      await tester.ensureVisible(buttonFinder);
      await tester.pumpAndSettle();
      await tester.tap(buttonFinder);
      await tester.pump();
      // this looks like a mess because i have no idea how to fix the issue and hoped spamming some things would help

      expect(find.byType(WriteReviewScreen), findsOneWidget);
    });
  });
}
