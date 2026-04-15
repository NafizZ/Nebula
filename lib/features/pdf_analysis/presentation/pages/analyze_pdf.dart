import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_cubit.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_state.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_cubit.dart';
import 'package:nebula/features/pdf_results/presentation/pages/result_page.dart';

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
      final cubit = context.read<PdfAnalysisCubit>();

      await cubit.analyzePdf(widget.filePath);

      if (mounted && cubit.state.status == PdfAnalysisStatus.success) {
        final result = cubit.state.result;

        if (result != null) {
          context.read<PdfResultCubit>().setResult(result);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PdfAnalysisCubit, PdfAnalysisState>(
        listener: (context, state) {
          if (state.status == PdfAnalysisStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
            Navigator.pop(context);
          }
        },
        child: const Center(
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
              SizedBox(height: 16),
              Text(
                'Extracting information...',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Generating AI summary...',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Finding important dates...',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
