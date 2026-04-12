class LocalAnalyzer {
  Map<String, dynamic> analyze(String text) {
    final dateRegex = RegExp(r'\d{1,2}[/-]\d{1,2}[/-]\d{2,4}');

    final dates = dateRegex.allMatches(text).map((e) => e.group(0)!).toList();

    final summary = text.split(" ").take(25).join(" ");

    return {
      "summary": summary,
      "dates": dates,
      "actions": ["Manual review needed"],
    };
  }
}
