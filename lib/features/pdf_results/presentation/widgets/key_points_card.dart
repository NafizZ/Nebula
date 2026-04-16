import 'package:flutter/material.dart';

class KeyPointsCard extends StatelessWidget {
  final List<String> keyPoints;

  const KeyPointsCard({super.key, required this.keyPoints});

  @override
  Widget build(BuildContext context) {
    if (keyPoints.isEmpty) return const SizedBox();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Key Points",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ...keyPoints.map(
            (point) => ListTile(
              leading: const Icon(Icons.circle, size: 8),
              title: Text(point),
            ),
          ),
        ],
      ),
    );
  }
}
