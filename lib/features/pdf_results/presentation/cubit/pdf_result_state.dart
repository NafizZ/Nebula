import 'package:equatable/equatable.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

enum PdfResultStatus { initial, ready }

class PdfResultState extends Equatable {
  final PdfResultStatus status;
  final AnalysisResultEntity? result;

  const PdfResultState({this.status = PdfResultStatus.initial, this.result});

  PdfResultState copyWith({
    PdfResultStatus? status,
    AnalysisResultEntity? result,
  }) {
    return PdfResultState(
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [status, result];
}
