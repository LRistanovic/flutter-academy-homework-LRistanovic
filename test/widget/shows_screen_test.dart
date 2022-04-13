import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/src/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/storage_repository.dart';
import 'package:tv_shows/shows/shows_screen.dart';
import 'package:tv_shows/shows/user_profile_screen.dart';
import 'package:tv_shows/shows/util/show.dart';
import 'package:tv_shows/shows/widgets/show_widget.dart';

import '../mocks.dart';

void main() {
  testWidgets('Shows are properly showing', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      final storageRepository = MockStorageRepository();
      when(networkRepository.fetchShows()).thenAnswer((_) async => [Show('id', 'name', 'description', 0, 0, null)]);
      when(networkRepository.storageRepository).thenReturn(storageRepository);
      when(storageRepository.user).thenReturn(User('id', 'email'));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              Provider<NetworkRepository>(create: (context) => networkRepository),
              ChangeNotifierProvider<StorageRepository>(create: (context) => storageRepository),
            ],
            child: const ShowsScreen(),
          ),
        ),
      );

      await tester.pump();
      final showFinder = find.byType(ShowWidget);

      expect(showFinder, findsWidgets);
    });
  });

  testWidgets('Loading and loading animation start immediately', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      final storageRepository = MockStorageRepository();
      when(networkRepository.fetchShows()).thenAnswer((_) async => [Show('id', 'name', 'description', 0, 0, null)]);
      when(networkRepository.storageRepository).thenReturn(storageRepository);
      when(storageRepository.user).thenReturn(User('id', 'email'));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              Provider<NetworkRepository>(create: (context) => networkRepository),
              ChangeNotifierProvider<StorageRepository>(create: (context) => storageRepository),
            ],
            child: const ShowsScreen(),
          ),
        ),
      );

      final lottieFinder = find.byType(Lottie);

      expect(lottieFinder, findsWidgets);
      await Future.delayed(const Duration(milliseconds: 10));
      await tester.pump();
      expect(lottieFinder, findsNothing);
    });
  });

  testWidgets('Profile button works', (WidgetTester tester) async {
    final networkRepository = MockNetworkRepository();
    final storageRepository = MockStorageRepository();
    when(networkRepository.fetchShows()).thenAnswer((_) async => [Show('id', 'name', 'description', 0, 0, null)]);
    when(networkRepository.storageRepository).thenReturn(storageRepository);
    when(storageRepository.user).thenReturn(User('id', 'email'));

    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NetworkRepository>(create: (context) => networkRepository),
          ChangeNotifierProvider<StorageRepository>(create: (context) => storageRepository),
        ],
        child: const MaterialApp(
          home: ShowsScreen(),
        ),
      ),
    );

    final buttonFinder = find.byType(OutlinedButton).first;
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.byType(UserProfileScreen), findsWidgets);
  });
}
