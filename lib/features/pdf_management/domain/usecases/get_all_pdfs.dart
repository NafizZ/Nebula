import 'package:nebula/features/pdf_management/domain/entities/pdf_entity.dart';
import 'package:nebula/features/pdf_management/domain/repositories/pdf_repository.dart';

class GetAllPdfs {
  final PdfRepository repository;

  GetAllPdfs(this.repository);

  Future<List<PdfEntity>> call() => repository.getAllPdfs();
}
