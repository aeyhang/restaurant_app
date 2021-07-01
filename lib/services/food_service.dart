// import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/food.dart';

class FoodService {
  static const String url = "http://localhost/api/";

  static Future<List<Food>> getFoods() async {
    try{
    const foodURL=url+'food_read.php';
    var response = await http.get(Uri.parse(foodURL));
    // List<TableData> tables = [];
    print(foodURL);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return foodFromJson(jsonString);
    } else {
      return [Food(id: 0,foodName: 'none',unitId: 0,categoryId: 0,foodPrice: 0.0,foodStatus: 0,updateStock: 0)];
    }
    }catch(e){
      return [Food(id: 0,foodName: 'none',unitId: 0,categoryId: 0,foodPrice: 0.0,foodStatus: 0,updateStock: 0)];
    }
  }

  static Future<String> postFood(Food food) async {
    try {
      final addURL = url + 'food_add.php';
  
      Map<String, String> data = {};
      data['foodName'] = food.foodName;
      data['unitID'] = food.unitId.toString();
      data['catID'] = food.categoryId.toString();
      data['foodPrice'] = food.foodPrice.toString();
      data['foodStatus'] = food.foodStatus.toString();
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
  
  static Future<String> updateFood(Food food) async {
    try {
      final addURL = url + 'food_edit.php';
  
      Map<String, String> data = {};
      data['id']=food.id.toString();
      data['foodName'] = food.foodName;
      data['unitID'] = food.unitId.toString();
      data['catID'] = food.categoryId.toString();
      data['foodPrice'] = food.foodPrice.toString();
      data['foodStatus'] = food.foodStatus.toString();
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
