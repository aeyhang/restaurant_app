import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/models/invoice.dart';
import 'package:restaurant_app/models/sale_detail.dart';
import 'package:restaurant_app/printings/print_invoice.dart';
import 'package:restaurant_app/printings/printing_sale_item.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/screens/order_screens/widgets/confirm_delete_dialog.dart';
import 'package:restaurant_app/screens/order_screens/widgets/discount_dialog.dart';
import 'package:restaurant_app/screens/order_screens/widgets/move_sale_data.dart';
import './sale_detial_sub_items.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:get/get.dart';

class SaleDetailPanel extends StatelessWidget {
  _printInvoice(){
    final List<Food> foodItems=[];
    final saleNumber=getSaleNumberByTableID();
    final saleDetails = saleDetailController.tempSaleDetails
                  .where((s) => s.saleNumber == saleNumber)
                  .toList();
    saleDetails.forEach((item) {
      foodItems.add(foodController.foods.firstWhere((f) => f.id==item.foodId));
     });
     Map<int, SaleDetail> map = {};
              for (var item in saleDetails) {
                map[item.foodId] = item;
              }
              var filteredList = map.values.toList();
              var saleMap =
                  getDuplicationFoods(list1: filteredList, list2: saleDetails);
    final invoice=Invoice(
        saleNumber:saleNumber,
   customerName:customerController.selectedCustomer.value.customerName,
   tableName: tableController.table.value.tableName,
    subTotal:getSubTotalBySaleNumber(
                saleController.tempSale.value.saleNumber),
    discount:saleController.tempSale.value.discount,
    foodItems: saleMap
    );
    PrintInvoice.printInvoice(invoice);
  }
  _buildItemCountAndFooodName(int itemCount, int foodID) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: itemCount.toString(),
              color: itemCount > 1 ? light : Colors.white70,
            ),
            if (itemCount > 1)
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton(
                    child: CustomText(
                      text: getFoodName(foodID),
                      color: light,
                    ),
                    onPressed: () {
                      saleDetailController.subItemID.value = foodID;
                      saleDetailController.showSubItem.value =
                          !saleDetailController.showSubItem.value;
                    },
                  ),
                ),
              )
            else
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                            text: getFoodName(foodID),
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _buildIcon(
      {required int itemCount,
      required IconData icon,
      required Callback onTap,
      required Color color}) {
    return IconButton(
      onPressed: itemCount > 1 ? () {} : onTap,
      icon: Icon(icon),
      iconSize: 18,
      color: color,
    );
  }

  _buildSubTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const CustomText(
          text: 'ລວມ: ',
          color: Colors.white70,
          size: 22,
        ),
        Obx(
          () => CustomText(
            text: formatNumber(getSubTotalBySaleNumber(
                saleController.tempSale.value.saleNumber)),
            color: Colors.white70,
            size: 22,
          ),
        ),
        const CustomText(
          text: ' ກີບ',
          color: Colors.white70,
          size: 22,
        ),
      ],
    );
  }

  _buildTotal(double discount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const CustomText(
          text: 'ຈຳນວນເງິນ: ',
          color: Colors.white70,
          size: 25,
        ),
        Obx(
          () => CustomText(
            text: formatNumber(saleController.tempSale.value.total),
            color: Colors.tealAccent,
            size: 35,
          ),
        ),
        const CustomText(
          text: ' ກີບ',
          color: Colors.white70,
          size: 22,
        ),
      ],
    );
  }

  void _showConfirmDialog(BuildContext context, int id, String foodName) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return ConfirmDeleteDialog(id: id, foodName: foodName);
      },
    );
  }

  void _showCheckBillDialog(BuildContext context, String saleNumber) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return DiscountDialog(
          saleNumber: saleNumber,
          sale: getTempSaleByTableID(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 348,
        height: MediaQuery.of(context).size.height - 220,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: dark,
          ),
          child: Container(
            height: 500,
            margin:
                const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 20),
            child: Obx(() {
              var amount = 0.0;
              final String saleNumber = getSaleNumberByTableID();
              final saleDetails = saleDetailController.tempSaleDetails
                  .where((s) => s.saleNumber == saleNumber)
                  .toList();

              var total = 0.0;
              saleDetails.forEach((s) {
                total += s.foodPrice;
              });
              Map<int, SaleDetail> map = {};
              for (var item in saleDetails) {
                map[item.foodId] = item;
              }
              var filteredList = map.values.toList();
              var saleMap =
                  getDuplicationFoods(list1: filteredList, list2: saleDetails);
              var saleList = saleMap.values.toList();
              int itemCount = 0;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Scrollbar(
                    child: Container(
                      height: 450,
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          amount = double.parse(saleList[index].toString()) *
                              filteredList[index].foodPrice;
                          itemCount = saleList[index];

                          List<bool> isMultipleItem = [];
                          itemCount > 1
                              ? isMultipleItem.add(true)
                              : isMultipleItem.add(false);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  _buildItemCountAndFooodName(
                                      itemCount, filteredList[index].foodId),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomText(
                                          text: formatNumber(amount),
                                          color: Colors.white70,
                                        ),
                                        Row(
                                          children: [
                                            _buildIcon(
                                                itemCount: itemCount,
                                                icon: Icons.print,
                                                onTap: () {
                                                  PrintSaleItem.printInvoice(
                                                      foodName: getFoodName(
                                                          filteredList[index]
                                                              .foodId),
                                                      tableName: tableController
                                                          .table
                                                          .value
                                                          .tableName);
                                                },
                                                color: Colors.white70),
                                            _buildIcon(
                                                itemCount: itemCount,
                                                icon: Icons.delete,
                                                onTap: () => _showConfirmDialog(
                                                    context,
                                                    filteredList[index].id,
                                                    getFoodName(
                                                        filteredList[index]
                                                            .foodId)),
                                                color: itemCount > 1
                                                    ? dark
                                                    : Colors.white70),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SaleDetialSubItem(saleDetails
                                  .where((e) =>
                                      e.foodId == filteredList[index].foodId)
                                  .toList())
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Divider(
                          height: 2,
                          color: Colors.white70,
                        ),
                        _buildSubTotal(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CustomText(
                              text: 'ສ່ວນຫຼຸດ: ',
                              color: Colors.white70,
                              size: 18,
                            ),
                            Obx(
                              () => TextButton(
                                child: CustomText(
                                  text: formatNumber(
                                      saleController.tempSale.value.discount),
                                  color: Colors.white70,
                                  size: 18,
                                ),
                                onPressed: () => _showCheckBillDialog(context,
                                    saleController.tempSale.value.saleNumber),
                              ),
                            ),
                            const CustomText(
                              text: ' ກີບ',
                              color: Colors.white70,
                              size: 22,
                            ),
                          ],
                        ),
                        _buildTotal(0),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          height: 50,
          width: 348,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _printInvoice(),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                      ),
                      color: light,
                    ),
                    child: const Center(
                        child: CustomText(
                      text: 'ເຊັກບີນ',
                      size: 22,
                      weight: FontWeight.bold,
                    )),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 2,
                color: dark,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    MoveSaleData.moveData(getTempSaleByTableID());
                    // _printInvoice();
                  },
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ),
                      color: light,
                    ),
                    child: const Center(
                        child: CustomText(
                      text: 'ຮັບເງິນ',
                      size: 22,
                      weight: FontWeight.bold,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
