import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/customer.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/models/unit.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

showFoodDialog({bool isAddNew = false}) {
  final _foodIdController = TextEditingController();
  final _foodNameController = TextEditingController();
  final _priceController = TextEditingController();
  if (!isAddNew) {
    _foodIdController.text = foodController.food.value.id.toString();
    _foodNameController.text = foodController.food.value.foodName;
    _priceController.text = formatNumber(foodController.food.value.foodPrice);
  }
  Get.defaultDialog(
      barrierDismissible: true,
      title: isAddNew ? 'ເພີ່ມອາຫານ' : 'ແກ້ໄຂອາຫານ',
      titleStyle:const TextStyle(color: dark, fontSize: 25),
      content: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 230,
        child: Column(
          children: [
            Row(children: [
              _buildTextField('ລະຫັດ', 80, _foodIdController),
              const SizedBox(
                width: 20,
              ),
              _buildTextField('ຊື່ອາຫານ', 300, _foodNameController),
              const SizedBox(
                width: 20,
              ),
              _buildTextField('ລາຄາ', 300, _priceController),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    children: [
                      CustomText(
                        text: 'ປະເພດອາຫານ:',
                        size: 18,
                      ),
                      _buildDropDownCategory(),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      CustomText(
                        text: 'ຫົວໜ່ວຍ:',
                        size: 18,
                      ),
                      _buildDropDownUnit(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(dark)),
                  child:const Text(
                    'ຍົກເລີກ',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Get.back(),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(dark)),
                  child: const Text(
                    'ບັນທຶກ',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _submitData(isAddNew, _foodNameController.text,
                        _priceController.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget _buildTextField(
    String text, double width, TextEditingController controller) {
  return Container(
    width: width,
    child: TextField(
      textAlign: TextAlign.end,
      style: const TextStyle(color: dark),
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: text, isDense: true),
    ),
  );
}

Widget _buildDropDownCategory() {
  var _categories = categoryController.categories;
  var _selectedCategory = categoryController.selectedCat.value;
  categoryController.setSelected(_selectedCategory);
  return Container(
    padding: const EdgeInsets.all(3.0),
    width: 200,
    // height: 65,
    child: Center(
      child: FittedBox(
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<Category>(
              value: categoryController.selectedCat.value,
              items: _categories.map((c) {
                return DropdownMenuItem<Category>(
                  child: CustomText(
                    text: c.catName,
                    color: dark,
                    size: 18,
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

_submitData(bool isAddNew, String foodName, String price) {
  double foodPrice = 0;
  if (foodName.isEmpty || price.isEmpty) {
    return;
  }
  var result = 'success';
  try {
    foodPrice = double.parse(price.replaceAll(',', ''));
  } catch (e) {
    result = e.toString();
  }
  if (result == 'success' && foodPrice >= 0) {
    isAddNew ? _addFood(foodName, foodPrice) : _updateFood(foodName, foodPrice);
  }
  Get.back();
}

_addFood(String foodName, double price) {
  foodController.addFood(
    Food(
        id: foodController.food.value.id,
        foodName: foodName,
        unitId: unitController.selectedUnit.value.id,
        categoryId: categoryController.selectedCat.value.id,
        foodPrice: price,
        foodStatus: 1,
        updateStock: 0),
  );
}

_updateFood(String foodName, double price) {
  foodController.updateFood(
    Food(
        id: foodController.food.value.id,
        foodName: foodName,
        unitId: unitController.selectedUnit.value.id,
        categoryId: categoryController.selectedCat.value.id,
        foodPrice: price,
        foodStatus: 1,
        updateStock: 0),
  );
}

Widget _buildDropDownUnit() {
  var _units = unitController.units;
  var _selectedUnit =
      _units.firstWhere((e) => e.id == foodController.food.value.unitId);
  unitController.selectedUnit(_selectedUnit);
  return Container(
    padding: const EdgeInsets.all(3.0),
    width: 200,
    // height: 65,
    child: Center(
      child: FittedBox(
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<Unit>(
              value: unitController.selectedUnit.value,
              items: _units.map((u) {
                return DropdownMenuItem<Unit>(
                  child: CustomText(
                    text: u.unitName,
                    color: dark,
                    size: 18,
                  ),
                  value: u,
                );
              }).toList(),
              onChanged: (Unit? newValue) {
                unitController.selectedUnit(newValue!);
              },
            ),
          ),
        ),
      ),
    ),
  );
}
