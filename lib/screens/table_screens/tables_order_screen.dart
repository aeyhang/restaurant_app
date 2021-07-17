import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/screens/table_screens/widgets/table_item.dart';
import 'package:get/get.dart';

class TablesOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () {

                return Scrollbar(
                  isAlwaysShown: true,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 120,
                    ),
                    itemCount: tableController.tables.length,
                    itemBuilder: (context, index) {
                      return TableItem(tableController.tables[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          color: dark,
          width: 350,
        ),
      ],
    );
  }
}
