import 'package:get/get.dart';
import '../models/table_data.dart';
import '../services/table_service.dart';

class TableController extends GetxController {
  static TableController instance=Get.find();
  var tables =<TableData>[].obs;
  var table = TableData(
          id: 0, tableName: 'none', seats: 0, description: 'none', tableFlag: 0)
      .obs;
  var count = 0.obs;
  var _isSavable = false.obs;
  @override
  void onInit() {
    // print('printing from table controller class');flu
    fetchTables();
    super.onInit();
  }

  bool getSavable() => _isSavable.value;
  set setSavable(bool value) => _isSavable.value = value;
  TableData getTable() => table.value;
  set setTable(TableData table) {
    this.table.value = table;
    update();
  }
 Future<String> addTable(TableData table) async{
   final result=await TableService.postTable(table);
   tables.add(table);
   return result;
 }
 Future<String> updateTable(TableData table, int index) async{
   final result=await TableService.updateTable(table);
   tables[index]=table;
   return result;
 }
  void fetchTables() async {
    tables.value = await TableService.getAllTables();
    update();
  }
}
