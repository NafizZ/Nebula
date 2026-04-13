import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/result_page.dart';

class AnalyzePdf extends StatefulWidget {
  final String filePath;
  const AnalyzePdf({super.key, required this.filePath});

  @override
  State<AnalyzePdf> createState() => _AnalyzePdfState();
}

class _AnalyzePdfState extends State<AnalyzePdf> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final cubit = context.read<PdfCubit>();

      await cubit.analyzePdf(widget.filePath);

      // 🚀 NAVIGATE AFTER AI FINISH
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ResultPage()),
        );
      }
    });
  }

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
            SizedBox(height: 16),
            Text(
              'Generating AI Dates...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
