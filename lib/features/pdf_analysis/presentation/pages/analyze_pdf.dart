import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_cubit.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_state.dart';
import 'package:nebula/features/pdf_analysis/presentation/pages/analyzing_ui.dart';
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

    /// 🔥 start fresh
    Future.microtask(() {
      context.read<PdfResultCubit>().clear();
      context.read<PdfAnalysisCubit>().analyzePdf(widget.filePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PdfAnalysisCubit, PdfAnalysisState>(
      listener: (context, state) {
        /// ❌ ERROR
        if (state.status == PdfAnalysisStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
          Navigator.pop(context);
        }

        /// ✅ SUCCESS (NO DELAY, NO MICROTASK)
        if (state.status == PdfAnalysisStatus.success && state.result != null) {
          final result = state.result!;

          /// save result
          context.read<PdfResultCubit>().setResult(result);

          /// navigate
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ResultPage()),
          );
        }
      },

      child: const AnalyzingUI(),
    );
  }
}
