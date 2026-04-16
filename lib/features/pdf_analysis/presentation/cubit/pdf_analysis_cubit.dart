import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pdf_analysis_state.dart';
import 'package:nebula/features/pdf_analysis/domain/usecases/analyze_pdf.dart';

class PdfAnalysisCubit extends Cubit<PdfAnalysisState> {
  final AnalyzePdf analyzePdfUseCase;

  PdfAnalysisCubit({required this.analyzePdfUseCase})
    : super(const PdfAnalysisState());

  DateTime? _lastCall;
  bool _isRunning = false;

  Future<void> analyzePdf(String path) async {
    // 🔥 prevent duplicate calls
    if (_isRunning) return;

    // 🔥 rate limit protection
    if (_lastCall != null &&
        DateTime.now().difference(_lastCall!).inSeconds < 5) {
      print("⛔ Blocked: rate limit protection");
      return;
    }

    _isRunning = true;
    _lastCall = DateTime.now();

    emit(const PdfAnalysisState(status: PdfAnalysisStatus.loading));

    try {
      final result = await analyzePdfUseCase(path);

      // 🔥 detect fallback result
      final isLocal =
          result.summary.contains("Local") || result.summary.contains("failed");

      emit(
        PdfAnalysisState(
          status: isLocal
              ? PdfAnalysisStatus.partial
              : PdfAnalysisStatus.success,
          result: result,
        ),
      );
    } catch (e) {
      emit(
        PdfAnalysisState(
          status: PdfAnalysisStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }

    _isRunning = false;
  }
}
