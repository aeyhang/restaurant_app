import 'package:get/get.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/services/sale_service.dart';

class SaleController extends GetxController {
  static SaleController instance = Get.find();
  var tempSales = <Sale>[].obs;
  var discount=0.obs;
  var total=0.obs;
  var tempSale = Sale(
    saleNumber: '',
    saleDate: DateTime.now(),
    tableId: 0,
    customerId: 0,
    subTotal: 0.0,
    discount: 0.0,
    total: 0.0,
    billStatus: '',
    invoiceDateTime: DateTime.now(),
  ).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTempSaleData();
  }
  void fetchTempSaleData() async {
    var data = await SaleService.getTempSales();
    tempSales.assignAll(data);  
    
    // refresh();
  }

  Future<String> addTempSale(Sale sale) async {
    final result = await SaleService.postTempSale(sale);

     tempSales.add(sale);
     tempSale.value=sale;
    return result;
  }
 Future<String> updateTempSale(Sale sale) async{
   final result=await SaleService.updateTempSale(sale);
   fetchTempSaleData();
   tempSale.value=sale;
   return result;
 }
 
}
