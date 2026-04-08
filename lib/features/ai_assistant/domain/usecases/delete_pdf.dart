import 'package:nebula/features/ai_assistant/domain/repositories/pdf_repository.dart';

class DeletePdf {
  final PdfRepository repository;
  DeletePdf(this.repository);
  Future<void> call(int id) => repository.deletePdf(id);
}
