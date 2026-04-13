import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey;

  late final GenerativeModel _model;

  GeminiService({required this.apiKey}) {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<Map<String, dynamic>> analyzePdf(String text) async {
    final prompt =
        """
You are a smart PDF analyzer.

Extract:
1. Short summary
2. Important dates
3. Key actions

Return ONLY in this JSON format:
{
  "summary": "...",
  "dates": ["..."],
  "actions": ["..."]
}

PDF TEXT:
$text
""";

    final response = await _model.generateContent([Content.text(prompt)]);

    final output = response.text ?? "";

    // Gemini sometimes returns extra text → safe parse
    return _parseJson(output);
  }

  Map<String, dynamic> _parseJson(String text) {
    try {
      final start = text.indexOf('{');
      final end = text.lastIndexOf('}');
      final jsonString = text.substring(start, end + 1);
      return Map<String, dynamic>.from(json.decode(jsonString));
    } catch (e) {
      return {
        "summary": text,
        "dates": [],
        "actions": ["Parse error - manual review needed"],
      };
    }
  }
}
