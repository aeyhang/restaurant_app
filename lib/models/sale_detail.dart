// To parse this JSON data, do
//
//     final saleDetail = saleDetailFromJson(jsonString);

import 'dart:convert';

List<SaleDetail> saleDetailFromJson(String str) => List<SaleDetail>.from(json.decode(str).map((x) => SaleDetail.fromJson(x)));

String saleDetailToJson(List<SaleDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaleDetail {
    SaleDetail({
         this.id=0,
        required this.saleNumber,
        required this.foodId,
        required this.foodPrice,
         this.discount=0,
         this.quantity=1,
         this.amount=0,
        required this.orderedDateTime,
        required this.description,
    });

    final int id;
    final String saleNumber;
    final int foodId;
    final double foodPrice;
    final double discount;
    final int quantity;
    final double amount;
    final DateTime orderedDateTime;
    final String description;

    factory SaleDetail.fromJson(Map<String, dynamic> json) => SaleDetail(
        id:int.parse( json["ID"]),
        saleNumber: json["SaleNumber"] as String,
        foodId: int.parse(json["FoodID"]),
        foodPrice:double.parse(json["FoodPrice"]),
        discount:double.parse( json["Discount"]),
        quantity:int.parse( json["Quantity"]),
        amount:double.parse( json["Amount"]),
        orderedDateTime: DateTime.parse(json["OrderedDateTime"]),
        description: json["Description"] as String,
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "SaleNumber": saleNumber,
        "FoodID": foodId,
        "FoodPrice": foodPrice,
        "Discount": discount,
        "Quantity": quantity,
        "Amount": amount,
        "OrderedDateTime": orderedDateTime.toIso8601String(),
        "Description": description,
    };
}
