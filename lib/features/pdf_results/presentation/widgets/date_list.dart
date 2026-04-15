import 'package:flutter/material.dart';

class DateList extends StatelessWidget {
  final List<String> dates;

  const DateList({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Important Dates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (dates.isEmpty) const Text('No dates found'),
            ...dates.map((date) => Text('- $date')),
          ],
        ),
      ),
    );
  }
}
