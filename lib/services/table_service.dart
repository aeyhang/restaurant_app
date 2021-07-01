// import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/table_data.dart';

class TableService {
  static const String url = "http://localhost/api/";
  // static var client=http.Client();

  static Future<List<TableData>> getAllTables() async {
    var response = await http.get(Uri.parse(url + 'table_api.php'));
    // List<TableData> tables = [];
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tableDataFromJson(jsonString);
    } else {
      return [
        TableData(
            id: 0,
            tableName: 'failed',
            seats: 0,
            description: 'failed',
            tableFlag: 0)
      ];
    }
  }

  static Future<String> postTable(TableData table) async {
    try {
      final addURL = url + 'table_add.php';
  
      Map<String, String> data = {};
      data['tableName'] = table.tableName;
      data['seats'] = table.seats.toString();
      data['description'] = table.description;
      data['tableFlag'] = table.tableFlag.toString();
      var response = await http.post(Uri.parse(addURL),
          body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('success adding data');
        print(response.body);
      }
      return 'success';
    } catch (e) {
      print(e);
      return 'error';
    }
  }
  static Future<String> updateTable(TableData table) async {
    try {
      final addURL = url + 'table_edit.php';
  
      Map<String, String> data = {};
      data['id']=table.id.toString();
      data['tableName'] = table.tableName;
      data['seats'] = table.seats.toString();
      data['description'] = table.description;
      data['tableFlag'] = table.tableFlag.toString();
      var response = await http.post(Uri.parse(addURL),
          body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('success adding data');
        print(response.body);
      }
      return 'success';
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
