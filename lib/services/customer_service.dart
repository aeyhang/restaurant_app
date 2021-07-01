
import 'package:http/http.dart' as http;

import '../models/customer.dart';

class CustomerService {
  static const String url = "http://localhost/api/";

  static Future<List<Customer>> getCategories() async {
    try{
    const unitURL=url+'customer_read.php';
    var response = await http.get(Uri.parse(unitURL));
    print(unitURL);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return customerFromJson(jsonString);
    } else {
      return [Customer(id: 0,customerName:  'none',gender: 0,phoneNumber: '00')];
    }
    }catch(e){
      return [Customer(id: 0,customerName:  'none',gender: 0,phoneNumber: '00')];
    }
  }
}