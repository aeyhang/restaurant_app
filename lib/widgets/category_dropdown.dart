import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import '../models/category.dart';

class CategoryDropdown extends StatelessWidget {
  final int catID;
  final double width;
  CategoryDropdown({this.catID = 1, this.width = 70});
  @override
  Widget build(BuildContext context) {
    return _buildDropDownCategory(catID, context);
  }

  Widget _buildDropDownCategory(int catID, BuildContext context) {
    var _selectedCat =
        categoryController.categories.firstWhere((c) => c.id == catID);
    categoryController.selectedCat(_selectedCat);
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: width,
      height: 50,
      child: Center(
        child: FittedBox(
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                alignment: AlignmentDirectional.center,
                itemHeight: 50,
                value: categoryController.selectedCat.value,
                items: categoryController.categories.map((c) {
                  var index = categoryController.categories.indexOf(c) + 1;
                  return DropdownMenuItem<Category>(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomText(
                                text: '$index :  ', color: dark, size: 25),
                            CustomText(text: c.catName, color: dark, size: 25),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(
                              text:
                                  '( ${foodController.foods.where((f) => f.categoryId == c.id).length} ລາຍການ )',
                              color: foodController.foods
                                      .where((f) => f.categoryId == c.id)
                                      .isNotEmpty
                                  ? light
                                  : dark,
                              size: 23,
                            ),
                          ],
                        ),
                      ],
                    ),
                    value: c,
                  );
                }).toList(),
                onChanged: (Category? newValue) {
                  categoryController.setSelected(newValue!);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
