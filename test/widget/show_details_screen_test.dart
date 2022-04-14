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
            showId: 3,
            user: User('id', 'email'),
          )
        ],
      );

      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: ShowDetailsScreen(show: Show('id', 'name', 'description', 0, 0, null)),
          ),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(const Key('write review button'));

      await tester.dragUntilVisible(buttonFinder, find.byType(CustomScrollView), const Offset(0, -50));
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 10));
      await tester.pumpAndSettle();
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(find.byType(WriteReviewScreen), findsOneWidget);
    });
  });

  testWidgets('CustomScrollView built properly', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<NetworkRepository>(
            create: (context) => networkRepository,
            child: ShowDetailsScreen(show: Show('id', 'name', 'description', 0, 0, null)),
          ),
        ),
      );

      final appBarFinder = find.byType(SliverAppBar);
      final descriptionFinder = find.byType(SliverToBoxAdapter).first;
      final reviewsFinder = find.byType(SliverToBoxAdapter).last;
      final writeReviewButtonFinder = find.byType(SliverFillRemaining);

      expect(appBarFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
      expect(reviewsFinder, findsOneWidget);
      expect(writeReviewButtonFinder, findsOneWidget);
    });
  });
}
