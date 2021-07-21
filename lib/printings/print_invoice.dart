import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/invoice.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';

class PrintInvoice {
  static printInvoice(Invoice invoice) async {
    final Uint8List phetsarath =
        File('assets/fonts/Phetsarath OT.ttf').readAsBytesSync();

    var format80m = PdfPageFormat.roll80;
    final font = pw.Font.ttf(phetsarath.buffer.asByteData());
    final doc = pw.Document();
    try {
      final logoImage =
          (await rootBundle.load('assets/images/logo_bw_small.png'))
              .buffer
              .asUint8List();
      doc.addPage(pw.Page(
          pageFormat: format80m,
          build: (pw.Context context) {
            return pw.Container(
              padding: const pw.EdgeInsets.only(right: 8),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Image(pw.MemoryImage(logoImage),
                          height: 50, width: 50),
                    ]),
                _buildRestaurantInfo(font),
                pw.Divider(height: 1),
                _buildTitle(font, invoice),
                pw.Divider(height: 1),
                _buildDetail(font, invoice),
                pw.Divider(height: 1),
                _buildPayment(font, invoice),
                pw.SizedBox(height: 3),
                pw.Divider(height: 1),
                _buildFooter(font),
              ]),
            ); // Center
          }));

      Printing.directPrintPdf(
          printer: const Printer(url: 'L80250 Series'),
          onLayout: (format) => doc.save());
    } catch (e) {
      print(e.toString());
    }
  }

  static pw.Widget _buildRestaurantInfo(pw.Font font) {
    return pw.Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Text(
        'ຮ້ານອາຫານ ຂ້າງຂອງ',
        style: pw.TextStyle(font: font, fontSize: 12),
      ),
      pw.Text(
        'Khangkhong Restaurant',
        style: const pw.TextStyle(fontSize: 10),
      ),
      pw.Text(
        'Tel:0307719 848    Whatsapp:020 7796 4876',
        style: const pw.TextStyle(fontSize: 8),
      ),
    ]);
  }

  static pw.Widget _buildTitle(pw.Font font, Invoice invoice) {
    return pw.Row(children: [
      // create table name and customer name container
      pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Text(
                  'ເບີໂຕະ:',
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
                pw.Text(
                  invoice.tableName,
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ]),
              pw.Row(children: [
                pw.Text(
                  'ລູກຄ້າ:',
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
                pw.Text(
                  invoice.customerName,
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ]),
            ]),
      ),
      // create table name and customer name container
      pw.Container(
        child:
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
          pw.Row(children: [
            pw.Text(
              'ວັນທີ:',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
            pw.Text(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'ເລກບີນ:',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
            pw.Text(
              invoice.saleNumber,
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
          ]),
        ]),
      ),
    ]);
  }

  static pw.Widget _buildPayment(pw.Font font, Invoice invoice) {
    return pw.Container(
      child: pw.Row(children: [
        pw.Spacer(),
        pw.Expanded(
          flex: 4,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'ລວມ:',
                        style: pw.TextStyle(font: font, fontSize: 10),
                      ),
                      pw.Text(
                        formatNumber(invoice.subTotal),
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'ສ່ວນຫລຸດ:',
                        style: pw.TextStyle(font: font, fontSize: 10),
                      ),
                      pw.Text(
                        formatNumber(invoice.discount),
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'ຈຳນວນເງີນ:',
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                      pw.Text(
                        formatNumber(invoice.subTotal - invoice.discount),
                        style: const pw.TextStyle(fontSize: 15),
                      ),
                    ]),
              ]),
        ),
      ]),
    );
  }

  static pw.Widget _buildDetail(pw.Font font, Invoice invoice) {
    //invoice.foodItems is a Map<int,int>
    //the Map's key is food ID
    //the Map's value is food item count

    return pw.Column(children: [
      ...invoice.foodItems.entries.map((e) {
        var food = foodController.foods.firstWhere((f) => f.id == e.key);
        return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(food.foodName,
                  style: pw.TextStyle(font: font, fontSize: 8)),
              pw.Row(
                  // mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                        pw.Text('${formatNumber(food.foodPrice)} x ${e.value} = ',
                            style: const pw.TextStyle(fontSize: 8)),
                        pw.Text(formatNumber(food.foodPrice * e.value),
                            style: const pw.TextStyle(fontSize: 8)),
                      
                    
                  ]),
            ]);
      }).toList(),
    ]);
  }
  static pw.Widget _buildFooter(pw.Font font){
    return pw.Center(child: pw.Text('ຂໍຂອບໃຈທຸກທ່ານທີ່ມາອຸດໜຸນ',style: pw.TextStyle(font: font,fontSize: 11,)) );
  }
}
