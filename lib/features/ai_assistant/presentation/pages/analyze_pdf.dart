import 'package:flutter/material.dart';

class AnalyzePdf extends StatefulWidget {
  const AnalyzePdf({super.key});

  @override
  State<AnalyzePdf> createState() => _AnalyzePdfState();
}

class _AnalyzePdfState extends State<AnalyzePdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.psychology, size: 70, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Analyzing PDF...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Extracting informatiom....',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Generating AI Summary...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
