import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/register/register_screen.dart';
import 'package:tv_shows/login/widgets/login_button.dart';
import 'package:tv_shows/login/widgets/login_credentials.dart';
import 'package:tv_shows/login/widgets/upper_decoration.dart';
import 'package:tv_shows/networking/network_repository.dart';

import '../mocks.dart';

void main() {
  testWidgets('Login screen built properly', (WidgetTester tester) async {
    final networkRepository = MockNetworkRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<NetworkRepository>(
          create: (context) => networkRepository,
          child: const RegisterScreen(),
        ),
      ),
    );

    final upperSectionFinder = find.byType(UpperDecoration);
    final middleSectionFinder = find.byType(LoginCredentials);
    final bottomSectionFinder = find.byType(LoginButton);

    expect(upperSectionFinder, findsOneWidget);
    expect(middleSectionFinder, findsOneWidget);
    expect(bottomSectionFinder, findsOneWidget);
  });
}
