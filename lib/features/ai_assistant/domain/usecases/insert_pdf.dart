import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';
import 'package:nebula/features/ai_assistant/domain/repositories/pdf_repository.dart';

class InsertPdf {
  final PdfRepository repository;
  InsertPdf(this.repository);
  Future<int> call(PdfEntity pdf) => repository.insertPdf(pdf);
}
