import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApiService {
  final gemini = Gemini.instance;

  Future<Map<String, dynamic>> analyze(String text) async {
    try {
      final response = await gemini.text('''
Return ONLY valid JSON:

{
  "summary": "",
  "dates": [],
  "actions": [],
  "keyPoints": [],
  "riskLevel": "Low",
  "importance": 0,
  "components": [
    {
      "type": "summary",
      "content": ""
    },
    {
      "type": "insights",
      "riskLevel": "Low",
      "importance": 0
    },
    {
      "type": "keyPoints",
      "items": []
    },
    {
      "type": "timeline",
      "items": []
    },
    {
      "type": "actions",
      "items": []
    }
  ]
}

TEXT:
$text
''');

      final output = response?.output ?? '';

      final jsonStart = output.indexOf('{');
      final jsonEnd = output.lastIndexOf('}');

      if (jsonStart == -1 || jsonEnd == -1) {
        throw Exception("Invalid response format");
      }

      final jsonString = output.substring(jsonStart, jsonEnd + 1);
      final data = jsonDecode(jsonString);

      return data;
    } catch (e) {
      return {
        "summary": "Error: $e",
        "dates": [],
        "actions": [],
        "keyPoints": [],
        "riskLevel": "Low",
        "importance": 0,
        "components": [],
      };
    }
  }
}
