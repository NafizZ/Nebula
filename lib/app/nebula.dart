import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/core/database/app_database.dart';
import 'package:nebula/features/pdf_analysis/data/datasources/local_analyzer.dart';
import 'package:nebula/features/pdf_analysis/data/datasources/nano_ai_service.dart';
import 'package:nebula/features/pdf_analysis/data/datasources/pdf_parser.dart';
import 'package:nebula/features/pdf_analysis/data/repositories/analysis_repository_impl.dart';
import 'package:nebula/features/pdf_analysis/domain/usecases/analyze_pdf.dart';
import 'package:nebula/features/pdf_analysis/presentation/cubit/pdf_analysis_cubit.dart';
import 'package:nebula/features/pdf_management/data/datasources/pdf_local_datasource.dart';
import 'package:nebula/features/pdf_management/data/repositories/pdf_repository_impl.dart';
import 'package:nebula/features/pdf_management/domain/usecases/delete_pdf.dart'
    show DeletePdf;
import 'package:nebula/features/pdf_management/domain/usecases/get_all_pdfs.dart';
import 'package:nebula/features/pdf_management/domain/usecases/insert_pdf.dart';
import 'package:nebula/features/pdf_management/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/pdf_management/presentation/pages/upload_page.dart';
import 'package:nebula/features/pdf_reader/data/datasources/reader_local_datasource.dart';
import 'package:nebula/features/pdf_reader/data/repositories/reader_repository_impl.dart';
import 'package:nebula/features/pdf_reader/domain/usecases/get_last_page.dart';
import 'package:nebula/features/pdf_reader/domain/usecases/save_last_page.dart';
import 'package:nebula/features/pdf_reader/presentation/cubit/pdf_reader_cubit.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_cubit.dart';

class Nebula extends StatelessWidget {
  const Nebula({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 DB
    final db = AppDatabase();

    // 🔥 DataSource
    final datasource = PdfLocalDatasource(db);

    // 🔥 Repository
    final repository = PdfRepositoryImpl(datasource);

    // 🔥 UseCases
    final getAllPdfs = GetAllPdfs(repository);
    final insertPdf = InsertPdf(repository);
    final deletePdf = DeletePdf(repository);

    // 🔥 Services
    final analysisRepository = AnalysisRepositoryImpl(
      pdfParser: PdfParser(),
      aiService: NanoAiService(),
      localAnalyzer: LocalAnalyzer(),
    );
    final analyzePdf = AnalyzePdf(analysisRepository);
    final readerRepository = ReaderRepositoryImpl(ReaderLocalDatasource(db));
    final getLastPage = GetLastPage(readerRepository);
    final saveLastPage = SaveLastPage(readerRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PdfCubit(
            getPdfs: getAllPdfs,
            addPdf: insertPdf,
            deletePdf: deletePdf,
          )..loadPdfs(),
        ),
        BlocProvider(
          create: (_) => PdfAnalysisCubit(analyzePdfUseCase: analyzePdf),
        ),
        BlocProvider(
          create: (_) => PdfReaderCubit(
            getLastPageUseCase: getLastPage,
            saveLastPageUseCase: saveLastPage,
          ),
        ),
        BlocProvider(create: (_) => PdfResultCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.green[50],
        ),
        home: const UploadPage(),
      ),
    );
  }
}
