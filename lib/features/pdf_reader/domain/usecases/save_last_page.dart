import 'package:nebula/features/pdf_reader/domain/repositories/reader_repository.dart';

class SaveLastPage {
  final ReaderRepository repository;

  SaveLastPage(this.repository);

  Future<void> call(String filePath, int page) {
    return repository.saveLastPage(filePath, page);
  }
}
