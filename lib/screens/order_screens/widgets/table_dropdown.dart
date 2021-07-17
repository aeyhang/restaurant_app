import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/table_data.dart';
import 'package:restaurant_app/screens/order_screens/food_items_operation.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class TableDropdown extends StatelessWidget {
  final int tableID;
  final double width;
  TableDropdown({this.tableID = 1, this.width = 70});
  @override
  Widget build(BuildContext context) {
    return _buildTableDropDown(tableID, context);
  }

  Widget _buildTableDropDown(int tableID, BuildContext context) {
    var _selectedTable =
        tableController.tables.firstWhere((t) => t.id == tableID);
    tableController.table.value=_selectedTable;
    return Container(
      padding: const EdgeInsets.all(3.0),
      width: width,
      child: Center(
        child: FittedBox(
          child: Obx(
            () => DropdownButtonHideUnderline(
              
              child: DropdownButton<TableData>(
                  
                value: tableController.table.value,
                items: tableController.tables.map((t) {
                  return DropdownMenuItem<TableData>(
                    
                    child: CustomText(text: t.tableName, color: dark, size: 18),
                    value: t,
                  );
                }).toList(),
                onChanged: (TableData? newValue) {
                  tableController.table(newValue!);
                    saleController.tempSale.value=getTempSaleByTableID();
                    saleDetailController.showSubItem.value=false;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
