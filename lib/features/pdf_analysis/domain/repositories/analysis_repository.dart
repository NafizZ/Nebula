import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';

abstract class AnalysisRepository {
  Future<AnalysisResultEntity> analyzePdf(String path);
}
