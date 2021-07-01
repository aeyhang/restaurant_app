// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

List<Unit> unitFromJson(String str) => List<Unit>.from(json.decode(str).map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unit {
    Unit({
        required this.id,
        required this.unitName,
    });

    final int id;
    final String unitName;

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id:int.parse( json["ID"]),
        unitName: json["UnitName"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "UnitName": unitName,
    };
}
