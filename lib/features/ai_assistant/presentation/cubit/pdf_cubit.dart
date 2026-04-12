import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pdf_entity.dart';
import '../../domain/usecases/get_all_pdfs.dart';
import '../../domain/usecases/insert_pdf.dart';
import '../../domain/usecases/delete_pdf.dart';
import '../../domain/usecases/update_pdf.dart';
import 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  final GetAllPdfs getPdfs;
  final InsertPdf addPdf;
  final DeletePdf deletePdf;
  final UpdatePdf updatePdf;

  PdfCubit({
    required this.getPdfs,
    required this.addPdf,
    required this.deletePdf,
    required this.updatePdf,
  }) : super(const PdfState());

  /// 🔄 Load all PDFs
  Future<void> loadPdfs() async {
    emit(state.copyWith(status: PdfStatus.loading));

    try {
      final result = await getPdfs();

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: result,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> addNewPdf(PdfEntity pdf) async {
    try {
      final alreadyExists = state.pdfs.any((item) => item.path == pdf.path);

      if (alreadyExists) {
        emit(state.copyWith(status: PdfStatus.duplicate));
        return false; // ❗ stop save
      }

      await addPdf(pdf); // DB insert

      final updated = [...state.pdfs, pdf];

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: updated,
          errorMessage: null,
        ),
      );

      return true;
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> removePdf(int id) async {
    try {
      await deletePdf(id);

      final result = await getPdfs();

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: result,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  PdfEntity? getPdfByPath(String path) {
    try {
      return state.pdfs.firstWhere((pdf) => pdf.path == path);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateLastPage(int id, int page) async {
    try {
      final pdfToUpdate = state.pdfs.firstWhere((pdf) => pdf.id == id);
      final updatedPdf = PdfEntity(
        id: pdfToUpdate.id,
        name: pdfToUpdate.name,
        path: pdfToUpdate.path,
        lastOpened: pdfToUpdate.lastOpened,
        lastPage: page,
      );

      await updatePdf(updatedPdf);

      final updated = state.pdfs
          .map((pdf) => pdf.id == id ? updatedPdf : pdf)
          .toList();

      emit(state.copyWith(pdfs: updated));
    } catch (e) {
      print('Error updating last page: $e');
    }
  }
}
