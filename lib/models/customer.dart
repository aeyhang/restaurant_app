// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
    Customer({
        required this.id,
        required this.customerName,
        required this.gender,
        required this.phoneNumber,
    });

    final int id;
    final String customerName;
    final int gender;
    final String phoneNumber;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id:int.parse(json["ID"]),
        customerName: json["CustomerName"] as String,
        gender:int.parse( json["Gender"]),
        phoneNumber: json["PhoneNumber"] as String,
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "CustomerName": customerName,
        "Gender": gender,
        "PhoneNumber": phoneNumber,
    };
}
