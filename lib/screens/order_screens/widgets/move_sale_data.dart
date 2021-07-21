import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/widgets/get_sale_details.dart';

class MoveSaleData {
  MoveSaleData();
  static moveData(Sale sale) {
    final String saleNumber = sale.saleNumber;
    saleController.addSale(Sale(
      saleNumber: sale.saleNumber,
      saleDate: sale.saleDate,
      tableId: sale.tableId,
      customerId: sale.customerId,
      subTotal: sale.subTotal,
      discount: sale.discount,
      total: sale.total,
      billStatus: 'closed',
      invoiceDateTime: DateTime.now(),
    ));
    saleController.deleteTempSale(sale.saleNumber);
    var saleDetails = GetSaleDetail.getTempSaleDetailBySaleNumber(saleNumber);
    for (var item in saleDetails) {
      saleDetailController.addSaleDetail(item);
      saleDetailController.deleteTempSaleBySaleNumber(saleNumber);
    }
  }
}
