import 'package:flutter/material.dart';

class ActionList extends StatelessWidget {
  final List<String> actions;

  const ActionList({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (actions.isEmpty) const Text('No actions found'),
            ...actions.map((action) => Text('- $action')),
          ],
        ),
      ),
    );
  }
}
