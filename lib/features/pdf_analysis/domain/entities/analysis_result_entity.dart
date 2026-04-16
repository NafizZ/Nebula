import 'package:equatable/equatable.dart';

class AnalysisResultEntity extends Equatable {
  final String summary;
  final List<String> dates;
  final List<String> actions;
  final List<String> keyPoints;
  final String riskLevel;
  final int importance;
  final Map<String, dynamic>? uiTree;

  const AnalysisResultEntity({
    required this.summary,
    this.dates = const [],
    this.actions = const [],
    this.keyPoints = const [],
    this.riskLevel = "Low",
    this.importance = 0,
    this.uiTree,
  });

  @override
  List<Object?> get props => [
    summary,
    dates,
    actions,
    keyPoints,
    riskLevel,
    importance,
    uiTree,
  ];
}
