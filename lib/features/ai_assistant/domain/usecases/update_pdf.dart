import '../entities/pdf_entity.dart';
import '../repositories/pdf_repository.dart';

class UpdatePdf {
  final PdfRepository repository;

  UpdatePdf(this.repository);

  Future<void> call(PdfEntity pdf) async {
    return await repository.updatePdf(pdf);
  }
}
