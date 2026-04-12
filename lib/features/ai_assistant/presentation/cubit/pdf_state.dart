import 'package:equatable/equatable.dart';
import '../../domain/entities/pdf_entity.dart';

enum PdfStatus { initial, loading, success, error, duplicate }

class PdfState extends Equatable {
  final PdfStatus status;
  final List<PdfEntity> pdfs;
  final String? errorMessage;

  // 🤖 AI FIELDS (ADD THESE)
  final String? summary;
  final List<String> dates;
  final List<String> actions;

  const PdfState({
    this.status = PdfStatus.initial,
    this.pdfs = const [],
    this.errorMessage,
    this.summary,
    this.dates = const [],
    this.actions = const [],
  });

  PdfState copyWith({
    PdfStatus? status,
    List<PdfEntity>? pdfs,
    String? errorMessage,
    String? summary,
    List<String>? dates,
    List<String>? actions,
  }) {
    return PdfState(
      status: status ?? this.status,
      pdfs: pdfs ?? this.pdfs,
      errorMessage: errorMessage ?? this.errorMessage,
      summary: summary ?? this.summary,
      dates: dates ?? this.dates,
      actions: actions ?? this.actions,
    );
  }

  @override
  List<Object?> get props => [
    status,
    pdfs,
    errorMessage,
    summary,
    dates,
    actions,
  ];
}
