import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/models/sale_detail.dart';
import 'package:intl/intl.dart';

String getFoodName(int id) {
  return foodController.foods
      .firstWhere((f) => f.id == id,
          orElse: () => Food(
              id: 0,
              foodName: 'none',
              unitId: 1,
              categoryId: 1,
              foodPrice: 0.0,
              foodStatus: 0,
              updateStock: 0))
      .foodName;
}

Map<int, int> getDuplicationFoods(
    {required List<SaleDetail> list1, required List<SaleDetail> list2}) {
  Map<int, int> map = {};
  for (var i = 0; i < list1.length; i++) {
    int counter = 0;
    list2.forEach((e) {
      e.foodId == list1[i].foodId ? counter++ : counter;
    });
    map[list1[i].foodId] = counter;
  }
  return map;
}

String getSaleNumberByTableID() {
  final String saleNumber = saleController.tempSales
      .firstWhere((s) => s.tableId == tableController.table.value.id,
          orElse: () => Sale(
                saleNumber: '',
                saleDate: DateTime.now(),
                tableId: 0,
                customerId: 0,
                subTotal: 0.0,
                discount: 0.0,
                total: 0.0,
                billStatus: '',
                invoiceDateTime: DateTime.now(),
              ))
      .saleNumber;
  return saleNumber;
}

Sale getTempSaleByTableID() {
  final sale = saleController.tempSales
      .firstWhere((t) => t.tableId == tableController.table.value.id,
          orElse: () => Sale(
                saleNumber: '',
                saleDate: DateTime.now(),
                tableId: 0,
                customerId: 0,
                subTotal: 0.0,
                discount: 0.0,
                total: 0.0,
                billStatus: '',
                invoiceDateTime: DateTime.now(),
              ));
  return sale;
}

String formatNumber(double number) {
  var formatter = NumberFormat('##,###');
  return formatter.format(number);
}

double getSubTotalBySaleNumber(String saleNumber) {
  double subTotal = 0;
  List<SaleDetail> list = saleDetailController.tempSaleDetails
      .where(
        (s) => s.saleNumber == saleNumber,
      )
      .toList();
  list.forEach((e) => subTotal += e.foodPrice);
  // for(var item in list){
  //   subTotal+=item.foodPrice;
  // }
  return subTotal;
}

double getTotal(String saleNumber, double discount) {
  var subTotal = getSubTotalBySaleNumber(saleNumber);
  var total = subTotal - discount;
  return total;
}

deleteFoodItem(int id) {
  saleDetailController.deleteTempSaleItem(id);
  var foodID=saleDetailController.tempSaleDetails.firstWhere((e) => e.id==id).foodId;
  var price=foodController.foods.firstWhere((f) => f.id==foodID).foodPrice;
  Sale sale=getTempSaleByTableID();
   saleController.updateTempSale(Sale(
          saleNumber: sale.saleNumber,
          saleDate: sale.saleDate,
          tableId: tableController.table.value.id,
          customerId: customerController.selectedCustomer.value.id,
          subTotal: sale.subTotal-price,
          discount: sale.discount,
          total: sale.total - price,
          billStatus: 'opened',
          invoiceDateTime: DateTime.now()));
}
