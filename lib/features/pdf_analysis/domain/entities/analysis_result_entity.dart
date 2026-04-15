import 'package:equatable/equatable.dart';

class AnalysisResultEntity extends Equatable {
  final String summary;
  final List<String> dates;
  final List<String> actions;

  const AnalysisResultEntity({
    required this.summary,
    this.dates = const [],
    this.actions = const [],
  });

  @override
  List<Object?> get props => [summary, dates, actions];
}
