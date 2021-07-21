import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class SaleOfTheDay extends StatelessWidget {
  final formatDate = DateFormat('dd-MM-yyyy');
  final formatDateTime = DateFormat('dd-MM-yyyy mm:ss');
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: double.infinity,
      padding: const EdgeInsets.all(15),      
      child: Obx(() {
        var salesOfTheDay = saleController.sales
            .where((s) =>
                formatDate.format(s.saleDate) ==
                formatDate.format(DateTime.now()))
            .toList();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [ Expanded(
                child: ListView.builder(
                    itemCount: salesOfTheDay.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(
                        salesOfTheDay[index].tableId,
                        salesOfTheDay[index].total,
                        salesOfTheDay[index].saleDate,
                      );
                    },
                  ),
                
            ),
            
            Container(
              height: 70,
              color: Colors.white70,
            )
          ],
        );
      }),
    );
  }

  _buildListTile(int tableID, double total, DateTime saleDate) {
    return Container(
      height: 70,
      color: Colors.white70,
      padding: const EdgeInsets.all(8),
      margin:const EdgeInsets.symmetric(vertical:5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: dark,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: CustomText(
                  text: tableController.tables
                      .firstWhere((t) => t.id == tableID)
                      .tableName,
                  size: 22,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListTile(
              title: CustomText(text: formatNumber(total), size: 22),
              subtitle: CustomText(
                text: formatDateTime.format(saleDate),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
