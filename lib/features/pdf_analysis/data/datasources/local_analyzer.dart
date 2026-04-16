class LocalAnalyzer {
  Map<String, dynamic> analyze(String text) {
    final dateRegex = RegExp(r'\d{4}-\d{2}-\d{2}');
    final dates = dateRegex.allMatches(text).map((e) => e.group(0)!).toList();

    final lower = text.toLowerCase();

    final actions = <String>[];

    if (lower.contains('meeting')) {
      actions.add('Schedule meeting reminder');
    }

    if (lower.contains('pay') || lower.contains('due')) {
      actions.add('Payment reminder needed');
    }

    return {
      "summary": text.split(' ').take(30).join(' '),
      "dates": dates,
      "actions": actions,
      "keyPoints": [],
      "riskLevel": "Low",
      "importance": 10,
      "uiTree": {
        "layout": "column",
        "children": [
          {
            "layout": "card",
            "children": [
              {"layout": "text", "value": "Local Analysis Result"},
            ],
          },
        ],
      },
    };
  }
}
