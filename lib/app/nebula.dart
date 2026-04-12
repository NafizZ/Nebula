import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/core/services/nano_ai_service.dart';
import 'package:nebula/core/services/pdf_parser.dart';
import 'package:nebula/features/ai_assistant/data/datasources/pdf_local_datasource.dart';
import 'package:nebula/features/ai_assistant/data/db/app_database.dart';
import 'package:nebula/features/ai_assistant/data/repositories/pdf_repository_impl.dart';
import 'package:nebula/features/ai_assistant/domain/usecases/delete_pdf.dart'
    show DeletePdf;
import 'package:nebula/features/ai_assistant/domain/usecases/get_all_pdfs.dart';
import 'package:nebula/features/ai_assistant/domain/usecases/insert_pdf.dart';
import 'package:nebula/features/ai_assistant/domain/usecases/update_pdf.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/upload_page.dart';

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
    final updatePdf = UpdatePdf(repository);
    final pdfParser = PdfParser();

    final aiService = NanoAiService(
      nanoAvailable: true, // later real check
      channel: const MethodChannel('nebula_nano_ai'),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PdfCubit(
            getPdfs: getAllPdfs,
            addPdf: insertPdf,
            deletePdf: deletePdf,
            updatePdf: updatePdf,
            pdfParser: pdfParser,
            aiService: aiService,
          )..loadPdfs(),
        ),
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
