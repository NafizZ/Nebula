import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart'
    as analysis;
import 'package:nebula/features/pdf_results/domain/entities/analysis_result_entity.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_state.dart';

class PdfResultCubit extends Cubit<PdfResultState> {
  PdfResultCubit() : super(const PdfResultState());

  void setResult(analysis.AnalysisResultEntity result) {
    emit(
      PdfResultState(
        status: PdfResultStatus.ready,
        result: AnalysisResultEntity.fromAnalysisResult(result),
      ),
    );
  }

  void clear() {
    emit(const PdfResultState());
  }
}
