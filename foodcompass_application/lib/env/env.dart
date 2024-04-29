import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class  Env {
  @EnviedField(varName: "SPOONACULAR_API_KEY")
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: "GEMINI_API_KEY")
  static const String geminiApiKey = _Env.geminiApiKey;
}