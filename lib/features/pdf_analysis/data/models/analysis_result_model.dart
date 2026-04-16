import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

class AnalysisResultModel extends AnalysisResultEntity {
  const AnalysisResultModel({
    required super.summary,
    super.dates,
    super.actions,
    super.keyPoints,
    super.riskLevel,
    super.importance,
    super.uiTree,
  });

  static Map<String, dynamic>? _safeUiTree(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return null;
  }

  factory AnalysisResultModel.fromMap(Map<String, dynamic> map) {
    return AnalysisResultModel(
      summary: map['summary'] ?? '',
      dates: List<String>.from(map['dates'] ?? []),
      actions: List<String>.from(map['actions'] ?? []),
      keyPoints: List<String>.from(map['keyPoints'] ?? []),
      riskLevel: map['riskLevel'] ?? "Low",
      importance: map['importance'] ?? 0,
      uiTree: _safeUiTree(map['uiTree']), // 🔥 FIXED
    );
  }
}
