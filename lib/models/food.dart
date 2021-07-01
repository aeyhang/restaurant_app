// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    Food({
        required this.id,
        required this.foodName,
        required this.unitId,
        required this.categoryId,
        required this.foodPrice,
        required this.foodStatus,
        required this.updateStock,
    });

    final int id;
    final String foodName;
    final int unitId;
    final int categoryId;
    final double foodPrice;
    final int foodStatus;
    final int updateStock;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        id:int.parse(json["ID"]),
        foodName: json["FoodName"] as String,
        unitId:int.parse(json["UnitID"]),
        categoryId:int.parse(json["CategoryID"]),
        foodPrice:double.parse( json["FoodPrice"]),
        foodStatus:int.parse(json["FoodStatus"]),
        updateStock:int.parse( json["UpdateStock"]),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "FoodName": foodName,
        "UnitID": unitId,
        "CategoryID": categoryId,
        "FoodPrice": foodPrice,
        "FoodStatus": foodStatus,
        "UpdateStock": updateStock,
    };
}
