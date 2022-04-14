import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/shows/util/show.dart';
import 'package:tv_shows/shows/widgets/show_widget.dart';

void main() {
  testWidgets('Show widget built properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShowWidget(
            show: Show('id', 'name', 'description', 3, 3, null),
          ),
        ),
      ),
    );

    final imageFinder = find.byType(Image);
    final nameFinder = find.text('name');
    final descriptionFinder = find.text('description');

    expect(imageFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
  });
}
