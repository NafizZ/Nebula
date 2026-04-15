import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApiService {
  final gemini = Gemini.instance;

  Future<Map<String, dynamic>> analyze(String text) async {
    try {
      final response = await gemini.text('''
Return ONLY JSON:

{
  "summary": "short summary",
  "dates": [],
  "actions": []
}

Text:
$text
''');

      final output = response?.output ?? '';

      final start = output.indexOf('{');
      final end = output.lastIndexOf('}');

      if (start == -1 || end == -1) {
        throw Exception("Invalid AI response");
      }

      final jsonString = output.substring(start, end + 1);
      final data = jsonDecode(jsonString);

      return {
        "summary": data["summary"] ?? "",
        "dates": List<String>.from(data["dates"] ?? []),
        "actions": List<String>.from(data["actions"] ?? []),
      };
    } catch (e) {
      return {"summary": "Error: $e", "dates": [], "actions": []};
    }
  }
}
