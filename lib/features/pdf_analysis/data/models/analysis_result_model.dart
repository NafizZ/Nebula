import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

class AnalysisResultModel extends AnalysisResultEntity {
  const AnalysisResultModel({
    required super.summary,
    super.dates,
    super.actions,
  });

  factory AnalysisResultModel.fromMap(Map<String, dynamic> map) {
    return AnalysisResultModel(
      summary: map['summary'] ?? '',
      dates: List<String>.from(map['dates'] ?? []),
      actions: List<String>.from(map['actions'] ?? []),
    );
  }
}
