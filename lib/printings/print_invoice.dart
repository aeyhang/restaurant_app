import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintInvoice {
  static printInvoice() async {
    final Uint8List fontData =
        File('assets/fonts/Phetsarath OT.ttf').readAsBytesSync();
    var format80m = PdfPageFormat.roll80;
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    try {
      //logo_bw_small
      // final logoImage =
      //     (await rootBundle.load('assets/images/logo_bw_small.png'))
      //         .buffer
      //         .asUint8List();
      // print(logoImage.elementSizeInBytes);
      // print('printing');
      doc.addPage(pw.Page(
          pageFormat: format80m,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  //  pw.Image(pw.MemoryImage(logoImage),
                  //     height: 50, width: 50),
                
                // pw.Text('something')
              ]),
            ); // Center
          })); // Page
      // Printing.directPrintPdf(
      //     printer: Printer(url: 'L80250 Series'),
      //     onLayout: (format) => doc.save());
    } catch (e) {
      print(e.toString());
    }
  }
}
