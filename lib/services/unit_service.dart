// import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/unit.dart';

class UnitService {
  static const String url = "http://localhost/api/";

  static Future<List<Unit>> getCategories() async {
    try{
    const unitURL=url+'unit_read.php';
    var response = await http.get(Uri.parse(unitURL));
    // List<TableData> tables = [];
    print(unitURL);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return unitFromJson(jsonString);
    } else {
      return [Unit(id: 0,unitName: 'none',)];
    }
    }catch(e){
      return [Unit(id: 0,unitName: 'none',)];
    }
  }
/*
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
  }*/
}
