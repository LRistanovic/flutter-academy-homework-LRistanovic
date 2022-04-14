import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/shows/util/show.dart';
import 'package:tv_shows/shows/widgets/show_widget.dart';

void main() {
  testWidgets('Show widget golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ShowWidget(show: Show('id', 'show name', 'show description', 0, 0, null))),
      ),
    );

    await expectLater(find.byType(ShowWidget), matchesGoldenFile('show_widget.png'));
  });
}
