import 'package:equatable/equatable.dart';

class AnalysisResultEntity extends Equatable {
  final String summary;
  final List<String> dates;
  final List<String> actions;
  final List<String> keyPoints;
  final String riskLevel;
  final int importance;
  final List<Map<String, dynamic>> components;

  const AnalysisResultEntity({
    required this.summary,
    this.dates = const [],
    this.actions = const [],
    this.keyPoints = const [],
    this.riskLevel = "Low",
    this.importance = 0,
    this.components = const [],
  });

  factory AnalysisResultEntity.fromMap(Map<String, dynamic> map) {
    return AnalysisResultEntity(
      summary: map['summary'] ?? '',
      dates: List<String>.from(map['dates'] ?? []),
      actions: List<String>.from(map['actions'] ?? []),
      keyPoints: List<String>.from(map['keyPoints'] ?? []),
      riskLevel: map['riskLevel'] ?? "Low",
      importance: map['importance'] ?? 0,
      components: List<Map<String, dynamic>>.from(map['components'] ?? []),
    );
  }

  @override
  List<Object?> get props => [
    summary,
    dates,
    actions,
    keyPoints,
    riskLevel,
    importance,
    components,
  ];
}
