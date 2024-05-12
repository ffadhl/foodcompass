import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodcompass_application/constants/apikeys_constant.dart';
import 'package:foodcompass_application/providers/gemini_ai_provider.dart';
import 'package:foodcompass_application/screens/gemini/gemini_ai_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(apiKey: geminiApiKey);
  group('CompassBot', () {
    testWidgets('Home screen : AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: ((context) => GeminiAiProvider()),
            ),
          ],
          child: const MaterialApp(
            home: GeminiAiScreen(),
          ),
        ),
      );
      expect(find.byType(AppBar), findsOneWidget);
    });
    testWidgets('Send message button test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: ((context) => GeminiAiProvider()),
            ),
          ],
          child: const MaterialApp(
            home: GeminiAiScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(LineIcons.paperPlane), findsOneWidget);
    });

    testWidgets('iamge message button test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: ((context) => GeminiAiProvider()),
            ),
          ],
          child: const MaterialApp(
            home: GeminiAiScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(LineIcons.image), findsOneWidget);
    });
  });
}
