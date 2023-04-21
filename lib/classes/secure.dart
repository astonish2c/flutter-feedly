import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secure {
  static String? apiKey;
  static String? searchEngineId;

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");

    apiKey = dotenv.env['API_KEY'];
    searchEngineId = dotenv.env['SEARCH_ENGINE_ID'];
  }
}
