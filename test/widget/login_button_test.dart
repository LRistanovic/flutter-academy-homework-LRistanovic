import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/widgets/login_button.dart';

import '../mocks.dart';

void main() {
  testWidgets('Login button built properly', (WidgetTester tester) async {
    const content = 'content';

    final credentialsProvider = MockCredentialsProvider();
    when(credentialsProvider.canLogin).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<CredentialsProvider>(
            create: (context) => credentialsProvider,
            child: LoginButton(buttonPressed: () {}, buttonContent: const Text(content)),
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(ElevatedButton);
    final contentFinder = find.text(content);

    expect(buttonFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
