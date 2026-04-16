import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';
import 'pdf_result_state.dart';

class PdfResultCubit extends Cubit<PdfResultState> {
  PdfResultCubit() : super(const PdfResultState());

  void setResult(AnalysisResultEntity result) {
    emit(PdfResultState(status: PdfResultStatus.ready, result: result));
  }

  void clear() {
    emit(const PdfResultState());
  }
}
