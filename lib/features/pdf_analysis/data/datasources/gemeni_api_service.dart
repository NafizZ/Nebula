import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApiService {
  final gemini = Gemini.instance;

  Future<Map<String, dynamic>> analyze(String text) async {
    final response = await gemini.text('''
Return ONLY valid JSON. No explanation.

Strict Rules:
- Root must be an object
- Must include "summary" (string)
- Must include "uiTree" (object)
- uiTree must follow this structure:
  {
    "layout": "column",
    "children": []
  }

Allowed layouts ONLY:
- column
- row
- text
- card
- badge
- spacer

UI Rules:
- Use "column" as root layout
- Use "card" to group sections (Summary, Dates, Actions, etc.)
- Use "text" for normal content
- Use "badge" for labels like "Low", "High", "Important"
- Use "row" for inline items (like badges)
- Use "spacer" for spacing between sections

Text Rules:
- Always use "value" field for text
- Do NOT use null or empty values

Structure Rules:
- Every card should have children
- Avoid empty children arrays
- Keep UI clean and structured

Example Output:
{
  "summary": "This document contains important information",
  "uiTree": {
    "layout": "column",
    "children": [
      {
        "layout": "card",
        "children": [
          { "layout": "text", "value": "Summary", "bold": true },
          { "layout": "text", "value": "This document contains important information" }
        ]
      },
      {
        "layout": "card",
        "children": [
          { "layout": "text", "value": "Important Dates", "bold": true },
          { "layout": "text", "value": "2026-04-12" }
        ]
      },
      {
        "layout": "row",
        "children": [
          { "layout": "badge", "value": "Review" },
          { "layout": "badge", "value": "Reminder" }
        ]
      }
    ]
  }
}

Now analyze this TEXT and generate UI:

$text
''');

    final output = response?.output ?? '';

    final start = output.indexOf('{');
    final end = output.lastIndexOf('}');

    final jsonString = output.substring(start, end + 1);
    return jsonDecode(jsonString);
  }
}
