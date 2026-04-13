class LocalAnalyzer {
  Map<String, dynamic> analyze(String text) {
    final dateRegex = RegExp(r'\d{4}-\d{2}-\d{2}');
    final dates = dateRegex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
    final actions = <String>[];
    final normalized = text.toLowerCase();

    if (normalized.contains('meeting')) {
      actions.add('Schedule meeting reminder');
    }

    if (normalized.contains('pay') || normalized.contains('due')) {
      actions.add('Payment reminder needed');
    }

    return {
      'summary': text.split(' ').take(30).join(' '),
      'dates': dates,
      'actions': actions,
    };
  }
}
