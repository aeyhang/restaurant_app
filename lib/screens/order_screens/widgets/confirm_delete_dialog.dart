import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final int id;
  final String foodName;
  ConfirmDeleteDialog({required this.id, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [ Container(
              height: 200,
              width: 700,
              padding: const EdgeInsets.all(20),
              color: dark,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      child: Row(
                        children: [
                          CustomText(
                            text: 'ທ່ານຕ້ອງການລຶບ  ',
                            size: 25,
                            color: light,
                          ),
                          CustomText(
                            text: foodName,
                            size: 25,
                            color: Colors.white70,
                          ),
                          CustomText(
                            text: ' ຈາກ ',
                            size: 25,
                            color: light,
                          ),
                          CustomText(
                            text: tableController.table.value.tableName,
                            size: 25,
                            color: Colors.white70,
                          ),
                          CustomText(
                            text: ' ແທ້ບໍ່?',
                            size: 25,
                            color: light,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        color: light,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 20),
                        child: TextButton(
                          child: CustomText(
                            text: 'ຍົກເລີກ',
                            size: 18,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Container(
                        color: light,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 20),
                        child: TextButton(
                          child: CustomText(
                            text: 'ລຶບ',
                            size: 18,
                          ),
                          onPressed: () {
                            deleteFoodItem(id);
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              )),
        
      ],
    );
  }
}
