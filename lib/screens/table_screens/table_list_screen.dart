import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/models/table_data.dart';
import 'package:restaurant_app/screens/product_screens/widgets/food_dialog.dart';
import 'package:restaurant_app/screens/table_screens/widgets/table_dialog.dart';
import 'package:restaurant_app/screens/table_screens/widgets/table_list_item.dart';
import 'package:restaurant_app/widgets/category_dropdown.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class TableListScreen extends StatelessWidget {
  List<TableData> _tables = [];
  var foodCount = 0;
  Container _buildFoodCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 20, bottom: 5),
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
                  width: 320,
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

  Widget _buildTableGridViewList() {
    return Obx(() {
      _tables = tableController.tables;
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 100,
          ),
          itemCount: _tables.length,
          itemBuilder: (context, index) {
            return TableListItem(table: _tables[index]);
          });
    });
  }

  Widget _createAddFoodButton() {
    return InkWell(
      onTap: () {
        showFoodDialog(isAddNew: true);
      },
      child: Container(
        child: Row(
          children: [
            CustomText(text: '+ ', size: 45, color: dark),
            CustomText(text: 'ເພີ່ມອາຫານ', size: 35, color: dark),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: ()=>showTableDialog(isAddNew: true),
                      child: Container(
                        child: Row(
                          children: [
                            CustomText(
                              text: '+',
                              size: 45,
                              color: dark,
                            ),
                            CustomText(
                              text: ' ເພີ່ມໂຕະ',
                              size: 35,
                              color: dark,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: _buildTableGridViewList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
