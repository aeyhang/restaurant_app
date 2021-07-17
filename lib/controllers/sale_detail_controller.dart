import 'package:get/get.dart';
import 'package:restaurant_app/models/sale_detail.dart';
import 'package:restaurant_app/services/sale_detail_service.dart';

class SaleDetailController extends GetxController {
  static SaleDetailController instance = Get.find();
  var showSubItem=false.obs;
  var subItemID=0.obs;
  var tempSaleDetails = <SaleDetail>[].obs;
  var tempSaleDetail = SaleDetail(
    id: 0,
    saleNumber: '',
    foodId: 0,
    foodPrice: 0.0,
    discount: 0.0,
    quantity: 0,
    amount: 0.0,
    orderedDateTime: DateTime.now(),
    description: '',
  ).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTempSaleDetails();
  }

  void fetchTempSaleDetails() async {
    var data=await SaleDetailService.getTempSaleDetails() ;
    tempSaleDetails.assignAll(data); 
  }
 Future<String> addTempSaleDetail(SaleDetail saleDetail) async{
   final result=await SaleDetailService.postData(saleDetail);
    fetchTempSaleDetails();
   return result;
 }
 Future<String> deleteTempSaleItem(int id)async{
   final result=await SaleDetailService.deleteData(id);
   fetchTempSaleDetails();
   return result;
 }
}
