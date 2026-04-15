import 'package:equatable/equatable.dart';

enum PdfReaderStatus { initial, loading, success, error }

class PdfReaderState extends Equatable {
  final PdfReaderStatus status;
  final String? filePath;
  final int lastPage;
  final String? errorMessage;

  const PdfReaderState({
    this.status = PdfReaderStatus.initial,
    this.filePath,
    this.lastPage = 1,
    this.errorMessage,
  });

  PdfReaderState copyWith({
    PdfReaderStatus? status,
    String? filePath,
    int? lastPage,
    String? errorMessage,
  }) {
    return PdfReaderState(
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      lastPage: lastPage ?? this.lastPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, filePath, lastPage, errorMessage];
}
