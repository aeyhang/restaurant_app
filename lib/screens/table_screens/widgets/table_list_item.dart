import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/table_data.dart';
import 'package:restaurant_app/screens/table_screens/widgets/table_dialog.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class TableListItem extends StatelessWidget {
  final TableData table;
  TableListItem({required this.table});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: dark,
              child: ClipOval(
                  child: Image.network(
                      'http://localhost/restaurant/img/table_white.png',
                      height: 70,
                      width: 50,
                      fit: BoxFit.contain,),
                      
                ),
              
            ),
          ),
          Flexible(
            child: ListTile(
              title: CustomText(
                text: table.tableName,
                size: 22,
                color: dark,
                weight: FontWeight.bold,
              ),
              subtitle: Text('ຈຳນວນບ່ອນນັ່ງ: ${table.seats}'),
              trailing: IconButton(
                onPressed: () {
                  tableController.table.value=table;
                  showTableDialog();
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
