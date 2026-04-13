class LocalAnalyzer {
  Map<String, dynamic> analyze(String text) {
    final dateRegex = RegExp(r'\d{4}-\d{2}-\d{2}');
    final dates = dateRegex.allMatches(text).map((e) => e.group(0)!).toList();

    final actions = <String>[];

    if (text.toLowerCase().contains("meeting")) {
      actions.add("Schedule meeting reminder");
    }

    if (text.toLowerCase().contains("pay") ||
        text.toLowerCase().contains("due")) {
      actions.add("Payment reminder needed");
    }

    return {
      "summary": text.split(" ").take(30).join(" "),
      "dates": dates,
      "actions": actions,
    };
  }
}
