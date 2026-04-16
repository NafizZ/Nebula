import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApiService {
  final gemini = Gemini.instance;

  Future<Map<String, dynamic>> analyze(String text) async {
    final response = await gemini.text('''
Return ONLY valid JSON.

Rules:
- Must return object with "uiTree" key
- uiTree must be a valid UI tree
- Allowed layouts: column, row, text, card, badge, spacer

Example:
{
  "summary": "text",
  "uiTree": {
    "layout": "column",
    "children": []
  }
}

TEXT:
$text
''');

    final output = response?.output ?? '';

    final start = output.indexOf('{');
    final end = output.lastIndexOf('}');

    final jsonString = output.substring(start, end + 1);
    return jsonDecode(jsonString);
  }
}
