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

  /// ➕ Add PDF
  Future<void> addNewPdf(PdfEntity pdf) async {
    try {
      await addPdf(pdf);

      final updated = List<PdfEntity>.from(state.pdfs)..add(pdf);

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: updated,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  /// ❌ Delete PDF
  Future<void> removePdf(int id) async {
    try {
      await deletePdf(id);

      final updated = state.pdfs.where((pdf) => pdf.id != id).toList();

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: updated,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  /// 🔍 Get PDF by path (FIX for your error)
  PdfEntity? getPdfByPath(String path) {
    try {
      return state.pdfs.firstWhere((pdf) => pdf.path == path);
    } catch (_) {
      return null;
    }
  }

  /// 📄 Update last page (async with DB persistence)
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
      // Handle error silently or emit error state
      print('Error updating last page: $e');
    }
  }
}
