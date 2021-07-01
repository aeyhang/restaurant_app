// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        required this.id,
        required this.catName,
        required this.description,
    });

    final int id;
    final String catName;
    final String description;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id:int.parse(json["ID"]),
        catName: json["CatName"] as String,
        description: json["Description"] as String,
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "CatName": catName,
        "Description": description,
    };
}
