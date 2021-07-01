import 'package:flutter/material.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/screens/table_screens/widgets/table_item.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:get/get.dart';

class TablesOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Obx(()=>Scrollbar(
          isAlwaysShown: true,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              mainAxisExtent: 120,
            ),
            itemCount: tableController.tables.length,
            itemBuilder: (context, index) {
              return TableItem(tableController.tables[index].tableName);
            },
          ),
        ),
      ),
    
    );
  }
}
