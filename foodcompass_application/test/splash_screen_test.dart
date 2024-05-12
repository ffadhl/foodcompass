import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodcompass_application/screens/splash/splash_screen.dart';

void main() {
  group('Splash Screen', () {
    testWidgets('Splash screen : Logo', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(Image), findsOneWidget);
    });
    testWidgets('Splash screen : Text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      await tester.pump(const Duration(seconds: 5));
      expect(find.text('FoodCompass.'), findsOneWidget);
    });
  });
}
