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
      const addURL = url + 'temp_sale_detail_add.php';

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
      const deleteURL = url + 'temp_sale_detail_delete_by_ID.php';


      var response = await http.post(Uri.parse(deleteURL),
          body: {'id':id.toString(),});
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
  static Future<String> deleteTempSaleDetails(String saleNumber)async{
    try {
      const deleteURL = url + 'temp_sale_detail_delete_by_salenumber.php';


      var response = await http.post(Uri.parse(deleteURL),
          body: {'saleNumber':saleNumber,});
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
//--------------------------------SaleDetails Table----------------
    static Future<String> postSaleDetail(SaleDetail saleDetail) async {
    try {
      const addURL = url + 'sale_detail_add.php';

      Map<String, String> data = {};
      data['saleNumber'] = saleDetail.saleNumber;
      data['foodID'] = saleDetail.foodId.toString();
      data['foodPrice'] = saleDetail.foodPrice.toString();
      data['orderDateTime']=saleDetail.orderedDateTime.toString();
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

}
