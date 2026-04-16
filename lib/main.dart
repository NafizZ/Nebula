import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nebula/app/nebula.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: dotenv.get("API_KEY"));
  print("API KEY: ${dotenv.env['API_KEY']}");

  runApp(Nebula());
}
