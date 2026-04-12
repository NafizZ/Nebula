import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';
import 'package:nebula/features/ai_assistant/domain/repositories/pdf_repository.dart';
import 'package:nebula/features/ai_assistant/data/datasources/pdf_local_datasource.dart';
import 'package:nebula/features/ai_assistant/data/models/pdf_model.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfLocalDatasource local;

  PdfRepositoryImpl(this.local);

  // 🔄 Entity → Model
  PdfModel _toModel(PdfEntity pdf) {
    return PdfModel(
      id: pdf.id,
      name: pdf.name,
      path: pdf.path,
      lastOpened: pdf.lastOpened,
      lastPage: pdf.lastPage,
    );
  }

  // 🔄 Model → Entity
  PdfEntity _toEntity(PdfModel model) {
    return PdfEntity(
      id: model.id,
      name: model.name,
      path: model.path,
      lastOpened: model.lastOpened,
      lastPage: model.lastPage,
    );
  }

  @override
  Future<int> insertPdf(PdfEntity pdf) {
    return local.insertPdf(_toModel(pdf));
  }

  @override
  Future<List<PdfEntity>> getAllPdfs() async {
    final result = await local.getAllPdfs();
    return result.map(_toEntity).toList();
  }

  @override
  Future<void> deletePdf(int id) {
    return local.deletePdf(id);
  }

  @override
  Future<void> updatePdf(PdfEntity pdf) {
    return local.updatePdf(_toModel(pdf));
  }
}
