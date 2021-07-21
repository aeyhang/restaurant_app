import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/sale_detail.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/screens/order_screens/widgets/confirm_delete_dialog.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class SaleDetialSubItem extends StatelessWidget {
  final List<SaleDetail> list;
  const SaleDetialSubItem(this.list);
  _buildIcon(
      {
      required IconData icon,
      required VoidCallback onTap,
      required Color color}) {
    return IconButton(
      onPressed: onTap,
      // mouseCursor: MouseCursor.defer,

      icon: Icon(icon),
      iconSize: 18,
      color: color,
    );
  }
void _showConfirmDialog(BuildContext context, int id,String foodName) {
    showDialog(
      barrierDismissible: true,      
      context: context,
      builder: (context) {
        return ConfirmDeleteDialog(id: id,foodName: foodName,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        // visible: saleDetailController.showSubItem.value,
        visible: list.first.foodId == saleDetailController.subItemID.value &&
                saleDetailController.showSubItem.value
            ? true
            : false,
        child: list.length > 1
            ? Column(
                children: list
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              CustomText(
                                text: getFoodName(e.foodId),
                                size: 15,
                                color: Colors.white38,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _buildIcon(
                                  icon: Icons.delete,
                                  onTap: () {
                                    _showConfirmDialog(context,e.id,getFoodName(e.foodId));
                                  },
                                  color: Colors.white38),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
            : Container(),
      );
    });
  }
}
