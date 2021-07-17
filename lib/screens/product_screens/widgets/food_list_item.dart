import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/screens/product_screens/widgets/food_dialog.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class FoodListItem extends StatelessWidget {
  final Food food;
  FoodListItem({required this.food});
  @override
  Widget build(BuildContext context) {
    final unit =
        unitController.units.firstWhere((u) => u.id == food.unitId).unitName;
    return Card(
      elevation: 8,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: light,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: CustomText(text: formatNumber(food.foodPrice)),
                ),
              ),
            ),
          ),
          Flexible(
            child: ListTile(
              title: CustomText(
                text: food.foodName,
                size: 22,
                color: dark,
                weight: FontWeight.bold,
              ),
              subtitle: Text('${formatNumber(food.foodPrice)} / $unit'),
              trailing: IconButton(
                onPressed: (){
                  foodController.food.value=food;
                  showFoodDialog();
                },
                icon: Icon(Icons.edit),
                iconSize: 22,
                color: dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
