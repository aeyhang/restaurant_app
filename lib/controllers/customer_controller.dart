import 'package:get/get.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';

class CustomerController extends GetxController {
  static CustomerController instance=Get.find();
  var customers=<Customer>[].obs;
  var selectedCustomer=Customer(id: 0,customerName:  'none',gender: 0,phoneNumber: '00').obs;
  void setSelected(Customer customer){
    selectedCustomer.value=customer;
  }
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }  
  void fetchCategories() async {
    customers.value = await CustomerService.getCategories();
    update();
  }
}
