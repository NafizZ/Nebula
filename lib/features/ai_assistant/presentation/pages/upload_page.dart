import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/preview_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _isLoading = false;
  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
    });
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null || result.files.isEmpty) return;
    final pickedFile = result.files.single;
    final filePath = pickedFile.path;
    if (!mounted) return;
    if (filePath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(filePath: filePath),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "PDF Analyzer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Upload and analyze your documents with AI",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
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
                            onPressed: () {
                              _pickFile();
                            },
                            icon: Icon(
                              Icons.file_upload_outlined,
                              size: 50,
                              color: Colors.blue[300],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tap to upload PDF",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Supported formats: PDF",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Files",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 3, // Example recent files count
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                            ),
                            title: Text("Document_${index + 1}.pdf"),
                            subtitle: Row(
                              children: [
                                Icon(Icons.access_time, size: 16),
                                Text("${index + 1} days ago"),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // Handle recent file tap (e.g., open or analyze)
                              print("Tapped on Document_${index + 1}.pdf");
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: double.infinity,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
