import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class TableItem extends StatelessWidget {
  final String tableName;
  const TableItem(this.tableName);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration:
            BoxDecoration(color: light, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(
              text: tableName,
              size: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'ສະຖານະ: ',
                  size: 18,
                ),
                const CustomText(
                  text: 'ວ່າງ ',
                  size: 18,
                  color: dark,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: dark),
                  child: const CustomText(
                    text: 'ກົດ',
                    color: Colors.white,
                    size: 18,
                  ),                  
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
