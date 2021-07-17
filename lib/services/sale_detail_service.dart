// import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/sale_detail.dart';

class SaleDetailService {
  static const String url = "http://localhost/api/";

  static Future<List<SaleDetail>> getTempSaleDetails() async {
    try {
      const foodURL = url + 'temp_sale_detail_read.php';
      var response = await http.get(Uri.parse(foodURL));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return saleDetailFromJson(jsonString);
      } else {
        return [
          SaleDetail(
            id: 0,
            saleNumber: '',
            foodId: 0,
            foodPrice: 0.0,
            discount: 0.0,
            quantity: 0,
            amount: 0.0,
            orderedDateTime: DateTime.now(),
            description: '',
          )
        ];
      }
    } catch (e) {
      return [
          SaleDetail(
            id: 0,
            saleNumber: '',
            foodId: 0,
            foodPrice: 0.0,
            discount: 0.0,
            quantity: 0,
            amount: 0.0,
            orderedDateTime: DateTime.now(),
            description: '',
          )
      ];
    }
  }

  static Future<String> postData(SaleDetail saleDetail) async {
    try {
      final addURL = url + 'temp_sale_detail_add.php';

      Map<String, String> data = {};
      data['saleNumber'] = saleDetail.saleNumber;
      data['foodID'] = saleDetail.foodId.toString();
      data['foodPrice'] = saleDetail.foodPrice.toString();
      data['description'] = saleDetail.description;
      var response = await http.post(Uri.parse(addURL),
          body: data);
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
  static Future<String> deleteData(int id)async{
    try {
      final deleteURL = url + 'temp_sale_detail_delete.php';


      var response = await http.post(Uri.parse(deleteURL),
          body: {'id':id.toString(),});
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  // static Future<String> updateFood(Food food) async {
  //   try {
  //     final addURL = url + 'food_edit.php';

  //     Map<String, String> data = {};
  //     data['id']=food.id.toString();
  //     data['foodName'] = food.foodName;
  //     data['unitID'] = food.unitId.toString();
  //     data['catID'] = food.categoryId.toString();
  //     data['foodPrice'] = food.foodPrice.toString();
  //     data['foodStatus'] = food.foodStatus.toString();
  //     var response = await http.post(Uri.parse(addURL),
  //         body: data);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print('success adding data');
  //       print(response.body);
  //     }
  //     return 'success';
  //   } catch (e) {
  //     print(e);
  //     return 'error';
  //   }
  // }
}
