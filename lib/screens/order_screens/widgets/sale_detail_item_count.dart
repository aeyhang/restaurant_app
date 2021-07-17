import 'package:restaurant_app/controllers/controllers.dart';

int saleItemsCount({required int foodID, required String saleNumber}) {
  int items = 0;
  var list = saleDetailController.tempSaleDetails
      .where((s) => s.saleNumber == saleNumber)
      .toList();
  for (var i = 0; i < list.length; i++) {
    if (list[i].foodId == foodID) items++;
  }
  return items;
}
