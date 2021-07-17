// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Sale> saleFromJson(String str) =>
    List<Sale>.from(json.decode(str).map((x) => Sale.fromJson(x)));

String saleToJson(List<Sale> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sale {
  Sale({
    required this.saleNumber,
    required this.saleDate,
    required this.tableId,
    required this.customerId,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.billStatus,
    required this.invoiceDateTime,
  });

  final String saleNumber;
  final DateTime saleDate;
  final int tableId;
  final int customerId;
  final double subTotal;
  final double discount;
  final double total;
  final String billStatus;
  final DateTime invoiceDateTime;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        saleNumber: json["SaleNumber"] as String,
        saleDate: DateTime.parse(json["SaleDate"]),
        tableId:int.parse(json["TableID"] ),
        customerId:int.parse(json["CustomerID"]),
        subTotal:double.parse( json["SubTotal"]),
        discount:double.parse( json["Discount"]),
        total:double.parse( json["Total"]),
        billStatus:json["BillStatus"] as String,
        invoiceDateTime: DateTime.parse(json["InvoiceDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "SaleNumber": saleNumber,
        "SaleDate": saleDate.toIso8601String(),
        "TableID": tableId,
        "CustomerID": customerId,
        "SubTotal": subTotal,
        "Discount": discount,
        "Total": total,
        "BillStatusID": billStatus,
        "InvoiceDateTime": invoiceDateTime.toIso8601String(),
      };
}
