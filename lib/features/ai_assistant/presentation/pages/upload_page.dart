import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/ai_assistant/domain/entities/pdf_entity.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_state.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/preview_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _isLoading = false;

  Future<void> _pickFile() async {
    setState(() => _isLoading = true);

    final result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null || result.files.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    final pickedFile = result.files.single;
    final filePath = pickedFile.path;

    if (!mounted || filePath == null) {
      setState(() => _isLoading = false);
      return;
    }

    final pdf = PdfEntity(
      name: pickedFile.name,
      path: filePath,
      lastPage: 0,
      lastOpened: DateTime.now(),
    );

    context.read<PdfCubit>().addNewPdf(pdf);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewPage(filePath: filePath)),
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    "PDF Analyzer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Upload and analyze your documents with AI",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// Upload Box
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue[50],
                            child: IconButton(
                              onPressed: _pickFile,
                              icon: Icon(
                                Icons.file_upload_outlined,
                                size: 50,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Tap to upload PDF"),
                          const Text(
                            "Supported formats: PDF",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Files",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      BlocBuilder<PdfCubit, PdfState>(
                        builder: (context, state) {
                          if (state.status == PdfStatus.loading) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (state.pdfs.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(30),
                              child: Center(child: Text("No PDFs yet")),
                            );
                          }

                          final pdfs = state.pdfs.reversed.toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: pdfs.length,
                            itemBuilder: (context, index) {
                              final pdf = pdfs[index];

                              return Card(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.red,
                                  ),
                                  title: Text(pdf.name),
                                  subtitle: Text("Last page: ${pdf.lastPage}"),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context.read<PdfCubit>().removePdf(
                                        pdf.id!,
                                      );
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PreviewPage(filePath: pdf.path),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        if (_isLoading)
          Container(
            color: Colors.black45,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
