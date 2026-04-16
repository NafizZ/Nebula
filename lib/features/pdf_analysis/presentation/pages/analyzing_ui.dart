import 'package:flutter/material.dart';

class AnalyzingUI extends StatelessWidget {
  const AnalyzingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology, size: 70, color: Colors.blue),
            SizedBox(height: 16),

            Text(
              'Analyzing PDF...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),
            CircularProgressIndicator(),

            SizedBox(height: 24),

            Text(
              'Extracting information...',
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 6),

            Text(
              'Generating AI summary...',
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 6),

            Text(
              'Finding important dates...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
