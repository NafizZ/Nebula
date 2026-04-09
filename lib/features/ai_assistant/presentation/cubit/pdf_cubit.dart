import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/pdf_entity.dart';
import '../../domain/usecases/get_all_pdfs.dart';
import '../../domain/usecases/insert_pdf.dart';
import '../../domain/usecases/delete_pdf.dart';

import 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  final GetAllPdfs getPdfs;
  final InsertPdf addPdf;
  final DeletePdf deletePdf;

  PdfCubit({
    required this.getPdfs,
    required this.addPdf,
    required this.deletePdf,
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

  //Add new PDF
  Future<void> addNewPdf(PdfEntity pdf) async {
    emit(state.copyWith(status: PdfStatus.loading));

    try {
      await addPdf(pdf);

      // Optimistic update (no DB reload)
      final updatedList = List<PdfEntity>.from(state.pdfs)..add(pdf);

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: updatedList,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  // Delete PDF
  Future<void> removePdf(int id) async {
    emit(state.copyWith(status: PdfStatus.loading));

    try {
      await deletePdf(id);

      final updatedList = state.pdfs.where((pdf) => pdf.id != id).toList();

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: updatedList,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }
}
