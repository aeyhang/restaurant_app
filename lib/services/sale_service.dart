// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/sale.dart';

import '../models/sale.dart';

class SaleService {
  static const String url = "http://localhost/api/";

  static Future<List<Sale>> getTempSales() async {
    try {
      const readURL = url + 'tempsale_read.php';
      var response = await http.get(Uri.parse(readURL));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return saleFromJson(jsonString);
      } else {
        return [
          Sale(
            saleNumber: '',
            saleDate: DateTime.now(),
            tableId: 0,
            customerId: 0,
            subTotal: 0.0,
            discount: 0.0,
            total: 0.0,
            billStatus: '',
            invoiceDateTime: DateTime.now(),
          )
        ];
      }
    } catch (e) {
      return [
        Sale(
          saleNumber: '',
          saleDate: DateTime.now(),
          tableId: 0,
          customerId: 0,
          subTotal: 0.0,
          discount: 0.0,
          total: 0.0,
          billStatus: '',
          invoiceDateTime: DateTime.now(),
        )
      ];
    }
  }

  static Future<List<Sale>> getTempSaleBySaleNumber() async {
    try {
      const foodURL = url + 'tempsale_read.php';
      var response = await http.get(Uri.parse(foodURL));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return saleFromJson(jsonString);
      } else {
        return [
          Sale(
            saleNumber: '',
            saleDate: DateTime.now(),
            tableId: 0,
            customerId: 0,
            subTotal: 0.0,
            discount: 0.0,
            total: 0.0,
            billStatus: '',
            invoiceDateTime: DateTime.now(),
          )
        ];
      }
    } catch (e) {
      return [
        Sale(
          saleNumber: '',
          saleDate: DateTime.now(),
          tableId: 0,
          customerId: 0,
          subTotal: 0.0,
          discount: 0.0,
          total: 0.0,
          billStatus: '',
          invoiceDateTime: DateTime.now(),
        )
      ];
    }
  }

  static Future<String> postTempSale(Sale sale) async {
    try {
      const addURL = url + 'temp_sale_add.php';
      Map<String, String> data = {};
      data['saleNumber'] = sale.saleNumber.toString();
      data['tableID'] = sale.tableId.toString();
      data['customerID'] = sale.customerId.toString();
      data['subTotal'] = sale.subTotal.toString();
      data['discount'] = sale.discount.toString();
      data['total'] = sale.total.toString();
      data['billStatus'] = sale.billStatus.toString();
      var response = await http.post(Uri.parse(addURL), body: data);
      if (response.statusCode == 200) {}
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateTempSale(Sale sale) async {
    try {
      const editURL = url + 'temp_sale_edit.php';

     Map<String, String> data = {};
      data['saleNumber'] = sale.saleNumber.toString();
      data['tableID'] = sale.tableId.toString();
      data['customerID'] = sale.customerId.toString();
      data['subTotal'] = sale.subTotal.toString();
      data['discount'] = sale.discount.toString();
      data['total'] = sale.total.toString();
      data['billStatus'] = sale.billStatus.toString();
      var response = await http.post(Uri.parse(editURL),
          body: data);
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
  static Future<String> deleteTempSale(String saleNumber) async {
    try {
      const editURL = url + 'temp_sale_delete.php';

     Map<String, String> data = {};
      // data['saleNumber'] = saleNumber;
      var response = await http.post(Uri.parse(editURL),
          body: {'saleNumber':saleNumber});
      if (response.statusCode == 200) {
      }
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  //----------------------------------------------Sales Table---------------------------
    static Future<String> postSale(Sale sale) async {
    try {
      const addURL = url + 'sale_add.php';
      Map<String, String> data = {};
      data['saleNumber'] = sale.saleNumber.toString();
      data['saleDate']=sale.saleDate.toString();
      data['tableID'] = sale.tableId.toString();
      data['customerID'] = sale.customerId.toString();
      data['subTotal'] = sale.subTotal.toString();
      data['discount'] = sale.discount.toString();
      data['total'] = sale.total.toString();
      data['billStatus'] = sale.billStatus.toString();
      var response = await http.post(Uri.parse(addURL), body: data);
      if (response.statusCode == 200) {}
      return 'success';
    } catch (e) {
      return 'error';
    }
  }
   static Future<List<Sale>> getSales() async {
    try {
      const readURL = url + 'sale_read.php';
      var response = await http.get(Uri.parse(readURL));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return saleFromJson(jsonString);
      } else {
        return [
          Sale(
            saleNumber: '',
            saleDate: DateTime.now(),
            tableId: 0,
            customerId: 0,
            subTotal: 0.0,
            discount: 0.0,
            total: 0.0,
            billStatus: '',
            invoiceDateTime: DateTime.now(),
          )
        ];
      }
    } catch (e) {
      return [
        Sale(
          saleNumber: '',
          saleDate: DateTime.now(),
          tableId: 0,
          customerId: 0,
          subTotal: 0.0,
          discount: 0.0,
          total: 0.0,
          billStatus: '',
          invoiceDateTime: DateTime.now(),
        )
      ];
    }
  }
}
