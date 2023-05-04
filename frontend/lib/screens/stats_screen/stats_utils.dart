import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfv;

void exportAndShowPdf(WidgetRef ref, BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hello World"),
        ); // Center
      })); // Page

  final pdfControllerPinch = pdfv.PdfControllerPinch(
    viewportFraction: 1.0,
    // document: PdfDocument.openAsset('assets/hello.pdf'),
    document: pdfv.PdfDocument.openData(
      pdf.save(),
    ),
    initialPage: 1,
  );

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PdfPreviewScreen(controller: pdfControllerPinch),
    ),
  );
}

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({Key? key, required this.controller})
      : super(key: key);

  final pdfv.PdfControllerPinch controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Work statistics'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              controller.previousPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
          pdfv.PdfPageNumber(
            controller: controller,
            builder: (_, loadingState, page, pagesCount) => Container(
              alignment: Alignment.center,
              child: Text(
                '$page/${pagesCount ?? 0}',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              controller.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
        ],
      ),
      body: pdfv.PdfViewPinch(
        builders: pdfv.PdfViewPinchBuilders<pdfv.DefaultBuilderOptions>(
          options: const pdfv.DefaultBuilderOptions(),
          documentLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
        ),
        controller: controller,
      ),
    );
  }
}
