import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodcompass_application/screens/welcome_screen/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: WelcomeScreen(),
    ));
    await tester.pump();
    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('FoodCompass'), findsOneWidget);
    expect(
      find.text(
          'FoodCompass is an online platform that provides quick and easy access to delicious recipes from around the world.'),
      findsOneWidget,
    );

    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });
}
