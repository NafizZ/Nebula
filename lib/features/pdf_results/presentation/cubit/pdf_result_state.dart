import 'package:equatable/equatable.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

enum PdfResultStatus { idle, loading, ready, error }

class PdfResultState extends Equatable {
  final PdfResultStatus status;
  final AnalysisResultEntity? result;
  final String? errorMessage;

  const PdfResultState({
    this.status = PdfResultStatus.idle,
    this.result,
    this.errorMessage,
  });

  PdfResultState copyWith({
    PdfResultStatus? status,
    AnalysisResultEntity? result,
    String? errorMessage,
  }) {
    return PdfResultState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
