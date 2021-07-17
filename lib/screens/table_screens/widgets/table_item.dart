import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/models/table_data.dart';
import 'package:restaurant_app/routing/routes.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class TableItem extends StatelessWidget {
  final TableData table;
  const TableItem(this.table);
  @override
  Widget build(BuildContext context) {
    final formatter=NumberFormat('##,###');
    final sale =
        saleController.tempSales.firstWhere((s) => s.tableId == table.id  ,
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
    return Card(
      child: Container(
        decoration:
            BoxDecoration(color: sale.tableId!=0? dark:light, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(
              text: table.tableName,
              size: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'ສະຖານະ: ',
                  size: 18,
                ),
                CustomText(
                  text:sale.tableId==0? 'ວ່າງ ':formatter.format(getSubTotalBySaleNumber(sale.saleNumber)),
                  size: 18,
                  color:sale.tableId==0? dark:Colors.white,
                  // weight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: dark),
                  child: CustomText(
                    text: 'ກົດ',
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    tableController.table.value = table;
                    saleController.tempSale.value=getTempSaleByTableID();
                    menuController.activeItem.value = OrderRoute;
                    navigationController.navigateTo(OrderRoute);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
