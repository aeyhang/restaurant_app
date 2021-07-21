import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/sale_detail.dart';

class GetSaleDetail {
  static List<SaleDetail> getTempSaleDetailBySaleNumber(saleNumber) =>
      saleDetailController.tempSaleDetails
          .where((s) => s.saleNumber == saleNumber)
          .toList();
}
