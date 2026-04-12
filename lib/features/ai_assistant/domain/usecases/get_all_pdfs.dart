import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';
import 'package:nebula/features/ai_assistant/domain/repositories/pdf_repository.dart';

class GetAllPdfs {
  final PdfRepository repository;
  GetAllPdfs(this.repository);
  Future<List<PdfEntity>> call() => repository.getAllPdfs();
}
