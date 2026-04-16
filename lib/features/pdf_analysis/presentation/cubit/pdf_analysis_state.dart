import 'package:equatable/equatable.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

enum PdfAnalysisStatus { initial, loading, success, partial, error }

class PdfAnalysisState extends Equatable {
  final PdfAnalysisStatus status;
  final AnalysisResultEntity? result;
  final String? errorMessage;
  final bool isCached;

  const PdfAnalysisState({
    this.status = PdfAnalysisStatus.initial,
    this.result,
    this.errorMessage,
    this.isCached = false,
  });

  PdfAnalysisState copyWith({
    PdfAnalysisStatus? status,
    AnalysisResultEntity? result,
    String? errorMessage,
    bool? isCached,
  }) {
    return PdfAnalysisState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage,
      isCached: isCached ?? this.isCached,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage, isCached];
}
