import 'package:flutter/material.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/action_list.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/ai_insights_card.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/key_points_card.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/summary_card.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/timeline_card.dart';

class GenUiBuilder {
  static Widget build(Map<String, dynamic> comp) {
    switch (comp['type']) {
      case 'summary':
        return SummaryCard(summary: comp['content'] ?? '');

      case 'insights':
        return AiInsightsCard(
          riskLevel: comp['riskLevel'] ?? 'Low',
          importance: comp['importance'] ?? 0,
        );

      case 'keyPoints':
        return KeyPointsCard(keyPoints: List<String>.from(comp['items'] ?? []));

      case 'timeline':
        return TimelineCard(dates: List<String>.from(comp['items'] ?? []));

      case 'actions':
        return ActionList(actions: List<String>.from(comp['items'] ?? []));

      default:
        return const SizedBox();
    }
  }
}
