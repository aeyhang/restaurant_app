import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/table_data.dart';

showTableDialog({bool isAddNew = false}) {
  final _idController = TextEditingController();
  final _tableNameController = TextEditingController();
  final _seatsController = TextEditingController();
  final _desController = TextEditingController();
  
  if (!isAddNew) {
    _idController.text = tableController.table.value.id.toString();
    _tableNameController.text = tableController.table.value.tableName;
    _seatsController.text = tableController.table.value.seats.toString();
    _desController.text = tableController.table.value.description;
  }else{
    _seatsController.text='0';
  }
  Get.defaultDialog(
      barrierDismissible: true,
      title: isAddNew ? 'ເພີ່ມຂໍ້ມູນໂຕະ' : 'ແກ້ໄຂຂໍ້ມູນໂຕະ',
      titleStyle: const TextStyle(color: dark, fontSize: 25),
      content: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 250,
        child: Column(
          children: [
            Row(children: [
              _buildTextField('ລະຫັດ', 80, _idController),
              const SizedBox(
                width: 20,
              ),
              _buildTextField('ເບີໂຕະ', 300, _tableNameController),
              const SizedBox(
                width: 20,
              ),
              _buildTextField('ຈຳນວນບ່ອນນັ່ງ', 300, _seatsController),
            ]),
            const SizedBox(
              height: 20,
            ),
            _buildTextField('ລາຍລະອຽດ', 720, _desController),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(dark)),
                  child: const Text(
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
                    _submitData(isAddNew, _tableNameController.text,
                        _seatsController.text, _desController.text);
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

_submitData(bool isAddNew, String tableName, String seats, String des) {
  var _seats = 0;
  if (tableName.isEmpty) {
    return;
  }
  var result = 'success';
  try {
    _seats = int.parse(seats);
  } catch (e) {
    result = e.toString();
  }
  if (result == 'success') {
    if (isAddNew) {
      _addTable(
        TableData(
            id: 0,
            tableName: tableName,
            seats: _seats,
            description: des,
            tableFlag: 1),
      );
    } else {
      _updateTable(
        TableData(
            id: tableController.table.value.id,
            tableName: tableName,
            seats: _seats,
            description: des,
            tableFlag: 1),
      );
    }
  }
  Get.back();
}

_addTable(TableData table) {
  tableController.addTable(table);
}

_updateTable(TableData table) {
  tableController.updateTable(table);
}
