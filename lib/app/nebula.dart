import 'package:flutter/material.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/upload_page.dart';

class Nebula extends StatelessWidget {
  const Nebula({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.green[50],
      ),
      home: UploadPage(),
    );
  }
}
