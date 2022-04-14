import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/widgets/login_credentials.dart';

import '../mocks.dart';

void main() {
  testWidgets('Login screen credentials section built properly', (WidgetTester tester) async {
    final credentialsProvider = MockCredentialsProvider();
    when(credentialsProvider.isVisible).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<CredentialsProvider>(
            create: (context) => credentialsProvider,
            child: LoginCredentials(
              title: 'title',
              description: 'description',
              showOtherButtonPressed: () {},
              showOtherButtonTitle: 'other title',
            ),
          ),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextField);
    final titleFinder = find.text('title');
    final descriptionFinder = find.text('description');
    final otherButtonFinder = find.byType(TextButton);

    expect(textFieldFinder, findsNWidgets(2));
    expect(titleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
    expect(otherButtonFinder, findsOneWidget);
  });
}
