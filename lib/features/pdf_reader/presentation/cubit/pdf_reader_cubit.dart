import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_reader/domain/usecases/get_last_page.dart';
import 'package:nebula/features/pdf_reader/domain/usecases/save_last_page.dart';
import 'package:nebula/features/pdf_reader/presentation/cubit/pdf_reader_state.dart';

class PdfReaderCubit extends Cubit<PdfReaderState> {
  final GetLastPage getLastPageUseCase;
  final SaveLastPage saveLastPageUseCase;

  PdfReaderCubit({
    required this.getLastPageUseCase,
    required this.saveLastPageUseCase,
  }) : super(const PdfReaderState());

  Future<void> loadLastPage(String filePath) async {
    emit(
      PdfReaderState(
        status: PdfReaderStatus.loading,
        filePath: filePath,
        lastPage: 1,
      ),
    );

    try {
      final lastPage = await getLastPageUseCase(filePath);
      emit(
        PdfReaderState(
          status: PdfReaderStatus.success,
          filePath: filePath,
          lastPage: lastPage < 1 ? 1 : lastPage,
        ),
      );
    } catch (e) {
      emit(
        PdfReaderState(
          status: PdfReaderStatus.error,
          filePath: filePath,
          lastPage: 1,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> saveLastPage(String filePath, int page) async {
    try {
      await saveLastPageUseCase(filePath, page);
      emit(
        state.copyWith(
          status: PdfReaderStatus.success,
          filePath: filePath,
          lastPage: page,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PdfReaderStatus.error,
          filePath: filePath,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
