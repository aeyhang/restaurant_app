import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/screens/product_screens/widgets/food_dialog.dart';
import 'package:restaurant_app/screens/product_screens/widgets/food_list_item.dart';
import 'package:restaurant_app/widgets/category_dropdown.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class FoodsListScreen extends StatelessWidget {
  List<Food> _foods = [];
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

  Widget _buildFoodGridViewList() {
    return Obx(() {
      var _catID = categoryController.selectedCat.value.id;
      _foods =
          foodController.foods.where((f) => f.categoryId == _catID).toList();
      // foodCount = _foods.length;
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 100,
          ),
          itemCount: _foods.length,
          itemBuilder: (context, index) {
            return FoodListItem(food: _foods[index]);
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFoodCategoryDropdown(),
                    _createAddFoodButton(),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: _buildFoodGridViewList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
