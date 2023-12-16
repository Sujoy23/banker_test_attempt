import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}
class _MyPdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hire This Guy ;p",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: SfPdfViewer.asset(
        'assets/resume.pdf'
      )
    );
  }
}