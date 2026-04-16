import 'package:flutter/material.dart';

class AiInsightsCard extends StatelessWidget {
  final String riskLevel;
  final int importance;

  const AiInsightsCard({
    super.key,
    required this.riskLevel,
    required this.importance,
  });

  Color _getRiskColor() {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.insights, color: _getRiskColor()),
        title: const Text("AI Insights"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Risk: $riskLevel"),
            Text("Importance: $importance%"),
          ],
        ),
      ),
    );
  }
}
