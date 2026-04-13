import 'package:nebula/features/pdf_management/domain/entities/pdf_entity.dart';

abstract class PdfRepository {
  Future<List<PdfEntity>> getAllPdfs();
  Future<int> insertPdf(PdfEntity pdf);
  Future<void> deletePdf(int id);
  Future<void> updatePdf(PdfEntity pdf);
}
