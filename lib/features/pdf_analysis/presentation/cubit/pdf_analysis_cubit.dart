import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/domain/usecases/analyze_pdf.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_state.dart';

class PdfAnalysisCubit extends Cubit<PdfAnalysisState> {
  final AnalyzePdf analyzePdfUseCase;

  PdfAnalysisCubit({required this.analyzePdfUseCase})
    : super(const PdfAnalysisState());

  Future<void> analyzePdf(String path) async {
    emit(const PdfAnalysisState(status: PdfAnalysisStatus.loading));

    try {
      final result = await analyzePdfUseCase(path);
      emit(PdfAnalysisState(status: PdfAnalysisStatus.success, result: result));
    } catch (e) {
      emit(
        PdfAnalysisState(
          status: PdfAnalysisStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
