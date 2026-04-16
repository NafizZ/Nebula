import 'package:nebula/features/pdf_analysis/data/datasources/local_analyzer.dart';
import 'package:nebula/features/pdf_analysis/data/datasources/gemeni_api_service.dart';
import 'package:nebula/features/pdf_analysis/data/datasources/pdf_parser.dart';
import 'package:nebula/features/pdf_analysis/data/models/analysis_result_model.dart';
import 'package:nebula/features/pdf_analysis/domain/entities/analysis_result_entity.dart';
import 'package:nebula/features/pdf_analysis/domain/repositories/analysis_repository.dart';

class AnalysisRepositoryImpl implements AnalysisRepository {
  final PdfParser pdfParser;
  final GeminiApiService aiService;
  final LocalAnalyzer localAnalyzer;

  AnalysisRepositoryImpl({
    required this.pdfParser,
    required this.aiService,
    required this.localAnalyzer,
  });

  Future<Map<String, dynamic>> _retryGemini(
    Future<Map<String, dynamic>> Function() call,
  ) async {
    for (int i = 0; i < 3; i++) {
      try {
        return await call();
      } catch (e) {
        print("⚠️ Retry ${i + 1} failed");
        await Future.delayed(Duration(seconds: 2 * (i + 1)));
      }
    }
    throw Exception("Gemini failed after retries");
  }

  @override
  Future<AnalysisResultEntity> analyzePdf(String path) async {
    final text = await pdfParser.extractText(path);

    if (text.trim().isEmpty) {
      throw Exception('No text found in PDF');
    }

    Map<String, dynamic> result;

    try {
      final response = await _retryGemini(() => aiService.analyze(text));

      print("🔥 AI RESPONSE: $response");

      result = response;
    } catch (e) {
      print("❌ AI FAILED → local fallback: $e");

      result = localAnalyzer.analyze(text);
    }

    return AnalysisResultModel.fromMap(result);
  }
}
