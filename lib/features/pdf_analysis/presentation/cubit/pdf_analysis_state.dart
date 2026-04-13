import 'package:equatable/equatable.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

enum PdfAnalysisStatus { initial, loading, success, error }

class PdfAnalysisState extends Equatable {
  final PdfAnalysisStatus status;
  final AnalysisResultEntity? result;
  final String? errorMessage;

  const PdfAnalysisState({
    this.status = PdfAnalysisStatus.initial,
    this.result,
    this.errorMessage,
  });

  PdfAnalysisState copyWith({
    PdfAnalysisStatus? status,
    AnalysisResultEntity? result,
    String? errorMessage,
  }) {
    return PdfAnalysisState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
