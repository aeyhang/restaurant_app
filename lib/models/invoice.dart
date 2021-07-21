import 'package:restaurant_app/models/food.dart';

class Invoice {
  final String saleNumber;
  final String customerName;
  final String tableName;
  final double subTotal;
  final double discount;
  final Map<int,int> foodItems;

  Invoice(
      {required this.saleNumber,
      required this.customerName,
      required this.tableName,
      required this.subTotal,
      required this.discount,
      required this.foodItems});
}
