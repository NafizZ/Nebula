import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_management/domain/entities/pdf_entity.dart';
import 'package:nebula/features/pdf_management/domain/usecases/delete_pdf.dart';
import 'package:nebula/features/pdf_management/domain/usecases/get_all_pdfs.dart';
import 'package:nebula/features/pdf_management/domain/usecases/insert_pdf.dart';
import 'package:nebula/features/pdf_management/presentation/cubit/pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  final GetAllPdfs getPdfs;
  final InsertPdf addPdf;
  final DeletePdf deletePdf;

  PdfCubit({
    required this.getPdfs,
    required this.addPdf,
    required this.deletePdf,
  }) : super(const PdfState());

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
      final exists = state.pdfs.any((p) => p.path == pdf.path);

      if (exists) {
        emit(state.copyWith(status: PdfStatus.duplicate));
        return false;
      }

      final id = await addPdf(pdf);

      final newPdf = PdfEntity(
        id: id,
        name: pdf.name,
        path: pdf.path,
        lastOpened: pdf.lastOpened,
        lastPage: pdf.lastPage,
      );

      emit(
        state.copyWith(
          status: PdfStatus.success,
          pdfs: [...state.pdfs, newPdf],
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

      final updated = state.pdfs.where((p) => p.id != id).toList();
      emit(state.copyWith(status: PdfStatus.success, pdfs: updated));
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

}
