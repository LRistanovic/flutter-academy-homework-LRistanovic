import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/login/widgets/upper_decoration.dart';

void main() {
  testWidgets('Upper decoration for login screen built properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UpperDecoration(),
        ),
      ),
    );

    final svgFinder = find.byType(SvgPicture);

    expect(svgFinder, findsNWidgets(3));
  });
}
