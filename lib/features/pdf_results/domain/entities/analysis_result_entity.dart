import 'package:equatable/equatable.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart'
    as analysis;

class AnalysisResultEntity extends Equatable {
  final String summary;
  final List<String> dates;
  final List<String> actions;

  const AnalysisResultEntity({
    required this.summary,
    this.dates = const [],
    this.actions = const [],
  });

  factory AnalysisResultEntity.fromAnalysisResult(
    analysis.AnalysisResultEntity result,
  ) {
    return AnalysisResultEntity(
      summary: result.summary,
      dates: result.dates,
      actions: result.actions,
    );
  }

  @override
  List<Object?> get props => [summary, dates, actions];
}
