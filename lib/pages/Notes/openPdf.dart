import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

import '../../util/colors.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    required this.file,
  });

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  bool isDispose = false;
  int indexPage = 0;
  @override
  void dispose() {
    isDispose = true;
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        backgroundColor: AppColors.appBar,
        title: Text(
          "Notes",
          style: GoogleFonts.lato(fontSize: 20),
        ),
        leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) {
          if (!isDispose) setState(() => this.pages = pages!);
        },
        onViewCreated: (controller) {
          if (!isDispose) setState(() => this.controller = controller);
        },
        onPageChanged: (indexPage, _) {
          if (!isDispose) setState(() => this.indexPage = indexPage!);
        },
      ),
    );
  }
}
