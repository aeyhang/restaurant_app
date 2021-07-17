import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/models/sale.dart';
import 'package:restaurant_app/screens/order_screens/customer_dropdown.dart';
import 'package:restaurant_app/screens/order_screens/food_item.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/screens/order_screens/sale_detail_panel.dart';
import 'package:restaurant_app/screens/order_screens/widgets/table_dropdown.dart';
import 'package:restaurant_app/widgets/category_dropdown.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class OrderScreen extends StatelessWidget {
  List<Food> _foods = [];
  var foodCount = 0;
  @override
  Widget build(BuildContext context) {
    final sale = getTempSaleByTableID();
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFoodCategoryDropdown(),
              _buildTopContainerBar(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    // _buildFoodCategoryDropdown(),
                    Container(
                      width: MediaQuery.of(context).size.width - 500,
                      height: MediaQuery.of(context).size.height - 175,
                      child: _buildFoodGridViewList(),
                    ),
                    // _buildFoodGridViewList(),
                  ],
                ),
              ),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 35),
                  child:  SaleDetailPanel(),
                ),
                Positioned(
                  left: 70,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 58,
                      width: 200,
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(
                        () => Center(
                          child: CustomText(
                            text: saleController.tempSale.value.saleNumber,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGridViewList() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Obx(() {
        var _catID = categoryController.selectedCat.value.id;
        _foods =
            foodController.foods.where((f) => f.categoryId == _catID).toList();
        foodCount = _foods.length;
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: 130,
            ),
            itemCount: _foods.length,
            itemBuilder: (context, index) {
              return FoodItem(_foods[index]);
            });
      }),
    );
  }

  Container _buildFoodCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 16, right: 20, bottom: 5),
      child: Row(
        children: [
          Card(
            elevation: 8,
            shadowColor: dark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryDropdown(
                  catID: categoryController.selectedCat.value.id == 0
                      ? 1
                      : categoryController.selectedCat.value.id,
                  width: 400,
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTopContainerBar() {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 16, right: 20, bottom: 5),
      child: Row(
        children: [
          Card(
            elevation: 8,
            shadowColor: dark,
            child: TableDropdown(
              tableID: tableController.table.value.id == 0
                  ? 1
                  : tableController.table.value.id,
              width: 220,
            ),
          ),
          Card(
            elevation: 8,
            shadowColor: dark,
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                child: CustomText(
                  text: 'ປ່ຽນໂຕະ / ຍ້າຍໂຕະ',
                  color: dark,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            elevation: 8,
            shadowColor: dark,
            child: CustomerDropdown(),
          ),
        ],
      ),
    );
  }
}
