import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:restaurant_app/Utils/print_invoice.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'dart:typed_data';

class DiscountDialog extends StatelessWidget {
  final String saleNumber;
  final _controller = TextEditingController();
  final Sale sale;
  DiscountDialog({required this.saleNumber, required this.sale});

  _submitData(String value) async {
    if (_controller.text.isEmpty) {
      return;
    }
    String result = 'success';
    double discount = 0;
    try {
      discount = double.parse(_controller.text);
    } catch (e) {
      result = e.toString();
    }
    if (result == 'success') {
      var subTotal =
          getSubTotalBySaleNumber(saleController.tempSale.value.saleNumber);
      _controller.text = formatNumber(discount);
      saleController.updateTempSale(Sale(
          saleNumber: saleNumber,
          saleDate: sale.saleDate,
          tableId: tableController.table.value.id,
          customerId: customerController.selectedCustomer.value.id,
          subTotal: subTotal,
          discount: discount,
          total: subTotal - discount,
          billStatus: 'opened',
          invoiceDateTime: DateTime.now()));
    }
    // PdfApi.openFile(pdfFile);

    // await Printing.layoutPdf(
    //   onLayout: (format) => _generatePdf(format),
    // );

    Get.back();
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
       pw.MultiPage(
          pageFormat: PdfPageFormat.roll80,
          build: (context) => [
            pw.Text('Invoice',style:const pw.TextStyle(fontSize: 22)),
            pw.Text('ຮ້ານອາຫານ ຂ້າງຂອງ'),
                
              ]),

      // pw.Page(
      //   pageFormat: PdfPageFormat.roll80,
      //   build: (context) => pw.Text('Data'),
      // ),
    );

    return pdf.save();
  }

  Widget _buildPdfPreview(BuildContext context) {
    final Uint8List fontData =
        File('assets/fonts/Phetsarath OT.ttf').readAsBytesSync();
    var pdfFormat = PdfPageFormat.roll80;
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (
          pw.Context context) {
          return pw.Center(
            child: pw.Text('ສະບາຍດີ', style: pw.TextStyle(font: ttf)),
          ); // Center
        })
        ); // Page

    // var printer=Printer(url:'192.168.1.254', );
    // var printer=Printing.listPrinters();
    return AlertDialog(actions: [
      Container(
        width: 500,
        height: 500,
        child: PdfPreview(
          allowPrinting: false,
          canDebug: false,
          onPrinted: (context) => Get.back(),
          allowSharing: false,
          canChangePageFormat: false,
          build: (pdfFormat) => doc.save(),
        ),
      ),
      TextButton(
          onPressed: () {
            
            Printing.directPrintPdf(printer: Printer(url: 'L80250 Series'), onLayout: (format)=>doc.save());
          },
          child: Text('Print')),
    ]);
  }

  _buildDialog(BuildContext context) {
    _controller.text = formatNumber(sale.discount);
    return AlertDialog(
      backgroundColor: dark,
      actions: [
        Container(
          height: 280,
          width: 400,
          padding: const EdgeInsets.all(20),
          color: dark,
          child: Column(
            children: [
              CustomText(
                text: 'ເຊັກບິນ ${tableController.table.value.tableName}',
                size: 25,
                color: Colors.white70,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'ລວມ:',
                          size: 22,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: formatNumber(getSubTotalBySaleNumber(
                              saleController.tempSale.value.saleNumber)),
                          size: 22,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: ' ກີບ',
                    size: 22,
                    color: Colors.white70,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'ສ່ວນຫລຸດ:',
                          size: 22,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            onSubmitted: (value) {
                              _submitData(value);
                            },
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 22),
                            controller: _controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: ' ກີບ',
                    size: 22,
                    color: Colors.white70,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'ຈຳນວນເງິນ:',
                          size: 22,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => CustomText(
                            text: formatNumber(
                                saleController.tempSale.value.total),
                            size: 22,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: ' ກີບ',
                    size: 22,
                    color: Colors.white70,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    child: CustomText(
                      text: 'ບັນທຶກ',
                      color: dark,
                      size: 18,
                    ),
                    onPressed: () {
                      _submitData(_controller.text);
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }
}
