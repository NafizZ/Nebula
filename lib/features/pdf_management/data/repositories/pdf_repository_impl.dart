import 'package:nebula/features/pdf_management/data/datasources/pdf_local_datasource.dart';
import 'package:nebula/features/pdf_management/data/models/pdf_model.dart';
import 'package:nebula/features/pdf_management/domain/entities/pdf_entity.dart';
import 'package:nebula/features/pdf_management/domain/repositories/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfLocalDatasource local;

  PdfRepositoryImpl(this.local);

  PdfModel _toModel(PdfEntity pdf) {
    return PdfModel(
      id: pdf.id,
      name: pdf.name,
      path: pdf.path,
      lastOpened: pdf.lastOpened,
      lastPage: pdf.lastPage,
    );
  }

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
