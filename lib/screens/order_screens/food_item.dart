import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/models/sale_detail.dart';
import 'package:restaurant_app/printings/printing_sale_item.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class FoodItem extends StatelessWidget {
  final Food _food;
  var formatter = NumberFormat('##,###');
  FoodItem(this._food);

  // _addData(Sale sale) {
  //   sale = getTempSaleByTableID();
  //   var saleNumber = _createSaleNumber();
  //   if (sale.saleNumber == '') {
  //     _addSaleDetail(saleNumber);
  //     _addTempSale(
  //       _food.foodPrice,
  //       0,
  //       0,
  //     );
  //   } else {
  //     saleNumber = sale.saleNumber;
  //     _addSaleDetail(saleNumber);
  //     _updateTempSale();
  //   }
  // }

  _addSaleDetail(String saleNumber) {
    saleDetailController.addTempSaleDetail(SaleDetail(
        saleNumber: saleNumber,
        foodId: _food.id,
        foodPrice: _food.foodPrice,
        orderedDateTime: DateTime.now(),
        description: ''));
  }

  _updateTempSale(Sale sale) {
    var subTotal = sale.subTotal + _food.foodPrice;
    saleController.updateTempSale(
      Sale(
        saleNumber: sale.saleNumber,
        saleDate: sale.saleDate,
        tableId: tableController.table.value.id,
        customerId: customerController.selectedCustomer.value.id,
        subTotal: subTotal,
        discount: 0,
        total: sale.total + _food.foodPrice,
        billStatus: 'opened',
        invoiceDateTime: DateTime.now(),
      ),
    );
  }

  _addTempSale(String saleNumber) {
    var subTotal = _food.foodPrice;
    var discount = 0.0;
    var total = subTotal - discount;
    var result = saleController.addTempSale(
      Sale(
        saleNumber: saleNumber,
        saleDate: DateTime.now(),
        tableId: tableController.table.value.id,
        customerId: customerController.selectedCustomer.value.id,
        subTotal: subTotal,
        discount: discount,
        total: total,
        billStatus: 'opened',
        invoiceDateTime: DateTime.now(),
      ),
    );
  }

  _createSaleNumber() => DateFormat('yyMMddHHmmss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration:
            BoxDecoration(color: light, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FittedBox(
              child: CustomText(
                text: _food.foodName,
                size: 25,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: formatter.format(_food.foodPrice),
                  size: 18,
                  color: dark,
                  weight: FontWeight.bold,
                ),
                const CustomText(
                  text: ' ກີບ / ',
                  size: 18,
                  color: dark,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: unitController.units
                      .firstWhere((u) => u.id == _food.unitId)
                      .unitName,
                  size: 18,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*
                   TextButton(                  
                      style: TextButton.styleFrom(backgroundColor: dark),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5),
                        child: CustomText(
                          text: 'ກົດສັ່ງ',
                          color: Colors.white,
                          size: 18,
                        ),
                      ),                    
                      onPressed:foodController.isButtonEnable.value? () {
                        foodController.isButtonEnable.value=false;
                        var saleNumber = getSaleNumberByTableID();
                        if (saleNumber == '') {
                          saleNumber = _createSaleNumber();
                        }
                         _addSaleDetail(saleNumber);
                        var sale = getTempSaleByTableID();
                        if (sale.saleNumber == '') {
                          _addTempSale(saleNumber);
                        } else {
                          _updateTempSale(sale);
                        }
                        // sale.saleNumber==''?_addTempSale(saleNumber,_food.foodPrice, 0, 0):_updateTempSale(sale);
                        Future.delayed(const Duration(milliseconds: 350),()=>foodController.isButtonEnable.value=true);
                        
                      }:null,
                    )*/
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: dark),
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: 'ກົດສັ່ງ',
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    onPressed: foodController.isButtonEnable.value
                        ? () {
                            foodController.isButtonEnable.value = false;
                            var saleNumber = getSaleNumberByTableID();
                            if (saleNumber == '') {
                              saleNumber = _createSaleNumber();
                            }
                            _addSaleDetail(saleNumber);
                            var sale = getTempSaleByTableID();
                            if (sale.saleNumber == '') {
                              _addTempSale(saleNumber);
                            } else {
                              _updateTempSale(sale);
                            }
                            if (_food.categoryId != 1) {
                              String result= PrintSaleItem.printInvoice(
                                  foodName: _food.foodName,
                                  tableName:
                                      tableController.table.value.tableName);
                              // sale.saleNumber==''?_addTempSale(saleNumber,_food.foodPrice, 0, 0):_updateTempSale(sale);
                              // Get.defaultDialog(
                              //   barrierDismissible: true,
                              //   title: result,
                              // );
                            }
                            Future.delayed(
                                const Duration(milliseconds: 350),
                                () =>
                                    foodController.isButtonEnable.value = true);
                          }
                        : null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
