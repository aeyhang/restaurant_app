// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// class PrintInvoice {
//   static print(String msg) async {
//     final PaperSize paper = PaperSize.mm80;

//     final profile = await CapabilityProfile.load();
//     final printer = NetworkPrinter(paper, profile);

//     final PosPrintResult res =
//         await printer.connect(' 192.168.209.2', port: 9100);

//     if (res == PosPrintResult.success) {
//       _testReceipt(printer,msg);
//       printer.disconnect();
//     }
//   }
//   static _testReceipt(NetworkPrinter printer,String msg) {
//     /*
//   printer.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//   printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//       styles:const PosStyles(codeTable: 'CP1252'));
//   printer.text('Special 2: blåbærgrød',
//       styles:const PosStyles(codeTable: 'CP1252'));

//   printer.text('Bold text', styles:const PosStyles(bold: true));
//   printer.text('Reverse text', styles:const PosStyles(reverse: true));
//   printer.text('Underlined text',
//       styles:const PosStyles(underline: true), linesAfter: 1);
//   printer.text('Align left', styles:const PosStyles(align: PosAlign.left));
//   printer.text('Align center', styles:const PosStyles(align: PosAlign.center));
//   printer.text('Align right',
//       styles:const PosStyles(align: PosAlign.right), linesAfter: 1);

//   printer.text('Text size 200%',
//       styles:const PosStyles(
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//       ));
//       */
//     printer.text(msg);

//     printer.feed(2);
//     printer.cut();
//   }
// }
