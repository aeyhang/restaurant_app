import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' ;
import 'package:restaurant_app/models/invoice.dart';
import 'package:restaurant_app/services/pdf_api.dart';
import 'dart:io';

class PdfInvoiceService {
  static Future<File> generate(String value) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
          pageFormat: PdfPageFormat.roll80,
          build: (context) => [
                _buildTitle(),
                
              ]),

      // Page(
      //   pageFormat: PdfPageFormat.roll80,
      //   build: (context) {
      //   return Text('hello');
      // }),
    );
    return PdfApi.saveDocument(name: 'invoice.pdf', pdf: pdf);
  }

  static Widget _buildTitle() {
    return Container(height: 100, child: Text('Invoice'));
  }

  static Widget _buildSomeText() {
    return Container(height: 100, child: Text('ຮ້ານອາຫານຂ້າງຂອງ'));
  }
}
