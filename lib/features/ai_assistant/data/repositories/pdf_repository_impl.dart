import 'package:nebula/features/ai_assistant/data/datasources/pdf_local_datasource.dart';
import 'package:nebula/features/ai_assistant/data/models/pdf_model.dart';

class PdfRepositoryImpl {
  final PdfLocalDatasource local;

  PdfRepositoryImpl(this.local);

  Future<int> insertPdf(PdfModel pdf) {
    return local.insertPdf(pdf);
  }

  Future<List<PdfModel>> getAllPdfs() {
    return local.getAllPdfs();
  }

  Future updateLastPage(int id, int page) {
    return local.updateLastPage(id, page);
  }

  Future deletePdf(int id) {
    return local.deletePdf(id);
  }
}
