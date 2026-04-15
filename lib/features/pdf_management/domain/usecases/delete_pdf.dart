import 'package:nebula/features/pdf_management/domain/repositories/pdf_repository.dart';

class DeletePdf {
  final PdfRepository repository;

  DeletePdf(this.repository);

  Future<void> call(int id) => repository.deletePdf(id);
}
