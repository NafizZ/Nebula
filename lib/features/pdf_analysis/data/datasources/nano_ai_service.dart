import 'package:gemini_nano_android/gemini_nano_android.dart';

class NanoAiService {
  final GeminiNanoAndroid gemini = GeminiNanoAndroid();

  Future<bool> isAvailable() async {
    try {
      return await gemini.isAvailable();
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>> analyze(String text) async {
    try {
      final results = await gemini.generate(
        prompt:
            '''
You are a text analyzer.

Return output in this format:

Summary: <short summary in 2 lines>
Dates: <list of important dates>
Actions: <list of actions>

Text:
$text
''',
      );

      if (results.isEmpty) {
        return _empty('No response from AI');
      }

      final output = results.first.toString().trim();

      if (output.isEmpty) {
        return _empty('Empty AI response');
      }

      return _parseOutput(output);
    } catch (e) {
      return _empty('Error: $e');
    }
  }

  Map<String, dynamic> _parseOutput(String text) {
    final summaryRegex = RegExp(
      r'Summary\s*:\s*(.*?)(?=Dates\s*:|Actions\s*:|$)',
      dotAll: true,
      caseSensitive: false,
    );

    final datesRegex = RegExp(
      r'Dates\s*:\s*(.*?)(?=Actions\s*:|$)',
      dotAll: true,
      caseSensitive: false,
    );

    final actionsRegex = RegExp(
      r'Actions\s*:\s*(.*)',
      dotAll: true,
      caseSensitive: false,
    );

    final summary = summaryRegex.firstMatch(text)?.group(1)?.trim() ?? '';
    final datesRaw = datesRegex.firstMatch(text)?.group(1) ?? '';
    final actionsRaw = actionsRegex.firstMatch(text)?.group(1) ?? '';

    return {
      'summary': summary.isEmpty ? 'No summary found' : summary,
      'dates': _toList(datesRaw),
      'actions': _toList(actionsRaw),
    };
  }

  List<String> _toList(String raw) {
    return raw
        .split('\n')
        .map((entry) => entry.replaceAll(RegExp(r'^[-*•\s]+'), '').trim())
        .where((entry) => entry.isNotEmpty)
        .toList();
  }

  Map<String, dynamic> _empty(String message) {
    return {'summary': message, 'dates': <String>[], 'actions': <String>[]};
  }
}
