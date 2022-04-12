import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/storage_repository.dart';
import 'package:tv_shows/shows/user_profile_screen.dart';

import '../mocks.dart';

void main() {
  testWidgets('User profile dialog goes away on submit', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final networkRepository = MockNetworkRepository();
      final storageRepository = MockStorageRepository();
      when(networkRepository.updateEmailAndImage()).thenAnswer((_) async => User('id', 'email'));
      when(networkRepository.updateEmail()).thenAnswer((_) async => User('id', 'email'));
      when(networkRepository.updateImage()).thenAnswer((_) async => User('id', 'email'));
      when(networkRepository.storageRepository).thenReturn(storageRepository);
      when(storageRepository.user).thenReturn(User('id', 'email'));
      when(storageRepository.deleteData()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MultiProvider(
              providers: [
                Provider<NetworkRepository>(create: (context) => networkRepository),
                ChangeNotifierProvider<StorageRepository>(create: (context) => storageRepository),
              ],
              child: const UserProfileScreen(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();
      await tester.tap(find.byKey(const Key('update button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(milliseconds: 10));

      expect(find.byType(UserProfileScreen), findsNothing);
    });
  });
}
