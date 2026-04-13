import 'package:nebula/features/pdf_management/domain/entities/pdf_entity.dart';
import 'package:nebula/features/pdf_management/domain/repositories/pdf_repository.dart';

class UpdatePdf {
  final PdfRepository repository;

  UpdatePdf(this.repository);

  Future<void> call(PdfEntity pdf) async {
    return repository.updatePdf(pdf);
  }
}
