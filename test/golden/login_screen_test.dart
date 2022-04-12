import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/login/login_screen.dart';
import 'package:tv_shows/networking/network_repository.dart';

import '../mocks.dart';

void main() {
  testWidgets('Login screen golden test', (WidgetTester tester) async {
    final networkRepository = MockNetworkRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<NetworkRepository>(
          create: (context) => networkRepository,
          child: const LoginScreen(),
        ),
      ),
    );

    await expectLater(find.byType(LoginScreen), matchesGoldenFile('login_screen.png'));
  });
}
