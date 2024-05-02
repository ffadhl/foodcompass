import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:foodcompass_application/constants/apikeys_constant.dart';
import 'package:foodcompass_application/providers/gemini_ai_provider.dart';
import 'package:foodcompass_application/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(apiKey: geminiApiKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => GeminiAiProvider()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Compass.',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
