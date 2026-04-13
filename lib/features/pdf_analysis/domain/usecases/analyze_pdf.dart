import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';
import 'package:nebula/features/pdf_analysis/domain/repositories/analysis_repository.dart';

class AnalyzePdf {
  final AnalysisRepository repository;

  AnalyzePdf(this.repository);

  Future<AnalysisResultEntity> call(String path) {
    return repository.analyzePdf(path);
  }
}
