import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/core/services/local_analyzer.dart';

import 'package:nebula/core/services/pdf_parser.dart';
import 'package:nebula/core/services/nano_ai_service.dart';

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

  final PdfParser pdfParser;
  final NanoAiService aiService;

  PdfCubit({
    required this.getPdfs,
    required this.addPdf,
    required this.deletePdf,
    required this.updatePdf,
    required this.pdfParser,
    required this.aiService,
  }) : super(const PdfState());

  // 📥 LOAD PDFs
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

  // ➕ ADD PDF (with duplicate check)
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

  // ❌ DELETE PDF (fast UI update)
  Future<void> removePdf(int id) async {
    try {
      await deletePdf(id);

      final updated = state.pdfs.where((p) => p.id != id).toList();

      emit(state.copyWith(status: PdfStatus.success, pdfs: updated));
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  // 📄 UPDATE LAST PAGE
  Future<void> updateLastPage(int id, int page) async {
    try {
      final pdf = state.pdfs.firstWhere((p) => p.id == id);

      final updatedPdf = PdfEntity(
        id: pdf.id,
        name: pdf.name,
        path: pdf.path,
        lastOpened: pdf.lastOpened,
        lastPage: page,
      );

      await updatePdf(updatedPdf);

      final updatedList = state.pdfs.map((p) {
        return p.id == id ? updatedPdf : p;
      }).toList();

      emit(state.copyWith(pdfs: updatedList));
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> analyzePdf(String path) async {
    emit(state.copyWith(status: PdfStatus.loading));

    try {
      final text = await pdfParser.extractText(path);

      if (text.trim().isEmpty) {
        emit(
          state.copyWith(
            status: PdfStatus.error,
            errorMessage: "No text found",
          ),
        );
        return;
      }

      Map<String, dynamic> result;

      final isAvailable = await aiService.isAvailable();

      if (isAvailable) {
        try {
          result = await aiService.analyze(text);
        } catch (e) {
          // fallback if AI fails
          result = LocalAnalyzer().analyze(text);
        }
      } else {
        result = LocalAnalyzer().analyze(text);
      }

      emit(
        state.copyWith(
          status: PdfStatus.success,
          summary: result['summary'],
          dates: List<String>.from(result['dates']),
          actions: List<String>.from(result['actions']),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PdfStatus.error, errorMessage: e.toString()));
    }
  }

  // 🔍 GET BY PATH
  PdfEntity? getPdfByPath(String path) {
    try {
      return state.pdfs.firstWhere((p) => p.path == path);
    } catch (_) {
      return null;
    }
  }
}
