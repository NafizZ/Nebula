import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';

abstract class PdfRepository {
  Future<List<PdfEntity>> getAllPdfs();
  Future<int> insertPdf(PdfEntity pdf);
  Future<void> deletePdf(int id);
}
