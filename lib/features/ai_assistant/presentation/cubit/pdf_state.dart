import 'package:equatable/equatable.dart';
import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';

enum PdfStatus { initial, loading, success, error }

class PdfState extends Equatable {
  final PdfStatus status;
  final List<PdfEntity> pdfs;
  final String? errorMessage;

  const PdfState({
    this.status = PdfStatus.initial,
    this.pdfs = const [],
    this.errorMessage,
  });

  PdfState copyWith({
    PdfStatus? status,
    List<PdfEntity>? pdfs,
    String? errorMessage,
  }) {
    return PdfState(
      status: status ?? this.status,
      pdfs: pdfs ?? this.pdfs,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pdfs, errorMessage];
}
