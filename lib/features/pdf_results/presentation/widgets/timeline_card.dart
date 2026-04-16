import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final List<String> dates;

  const TimelineCard({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    if (dates.isEmpty) return const SizedBox();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Timeline",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ...dates.map(
            (date) => ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(date),
            ),
          ),
        ],
      ),
    );
  }
}
