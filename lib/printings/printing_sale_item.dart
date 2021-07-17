import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintSaleItem {
  static printInvoice({required String foodName, required String tableName}) {
    final Uint8List fontData =
        File('assets/fonts/Phetsarath OT.ttf').readAsBytesSync();
    var format80m = PdfPageFormat.roll80;
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    doc.addPage(
        // pw.MultiPage(
        // pageFormat: format80m,
        // build: (context) => [
        //       pw.Text(tableName),
        //       pw.Text(foodName),
        //       pw.Text('${DateTime.now().hour.toString()} : ${DateTime.now().minute.toString()}'),
        //     ]),
        pw.Page(          
            pageFormat: PdfPageFormat.roll80,
            build: (pw.Context context) {
              return pw.Padding(
                padding: pw.EdgeInsets.only(right: 8,),
                  child: pw.Column(
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(tableName, style: pw.TextStyle(font: ttf)),
                        pw.Text(
                            '${DateTime.now().hour.toString()} : ${DateTime.now().minute.toString()}'),
                      ]),
                  pw.Text(foodName,
                      style: pw.TextStyle(font: ttf, fontSize: 28)),
                  
                ],
              )); // Center
            })); // Page
    Printing.directPrintPdf(
        printer: Printer(url: 'L80250 Series'),
        onLayout: (format) => doc.save());
  }
}
