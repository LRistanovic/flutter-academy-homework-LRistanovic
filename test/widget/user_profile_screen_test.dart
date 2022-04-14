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
  testWidgets('User profile screen built properly', (WidgetTester tester) async {
    final storageRepository = MockStorageRepository();
    final networkRepository = MockNetworkRepository();
    when(storageRepository.deleteData()).thenAnswer((_) async {});
    when(storageRepository.user).thenReturn(User('id', 'email'));
    when(networkRepository.updateEmailAndImage()).thenAnswer((_) async => User('id', 'email'));
    when(networkRepository.updateEmail()).thenAnswer((_) async => User('id', 'email'));
    when(networkRepository.updateImage()).thenAnswer((_) async => User('id', 'email'));
    when(networkRepository.storageRepository).thenReturn(storageRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<StorageRepository>(create: (context) => storageRepository),
              Provider<NetworkRepository>(create: (context) => networkRepository),
            ],
            child: const UserProfileScreen(),
          ),
        ),
      ),
    );
  });
}
