// To parse this JSON data, do
//
//     final tableData = tableDataFromJson(jsonString);

import 'dart:convert';

List<TableData> tableDataFromJson(String str) => List<TableData>.from(json.decode(str).map((x) => TableData.fromJson(x)));

String tableDataToJson(List<TableData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableData {
  TableData({
    required this.id,
    required this.tableName,
    required this.seats,
    required this.description,
    required this.tableFlag,
  });
  final int id;
  final String tableName;
  final int seats;
  final String description;
  final int tableFlag;

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
    id: int.parse( json['ID']) ,
    tableName: json['TableName'] as String,
    seats:int.parse( json['Seats'] ),
    description: json['Description'] as String,
    tableFlag:int.parse(json['TableFlag'] ),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TableName": tableName,
    "Seats": seats,
    "Description": description,
    "TableFlag": tableFlag,
  };
}
