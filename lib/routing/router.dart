
import 'package:flutter/material.dart';
import 'package:restaurant_app/routing/routes.dart';
import 'package:restaurant_app/screens/order_screens/order_screen.dart';
import 'package:restaurant_app/screens/product_screens/foods_list_screen.dart';
import 'package:restaurant_app/screens/table_screens/table_list_screen.dart';
import 'package:restaurant_app/screens/table_screens/tables_order_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case tablesOrderRoute:
        return _getPageRoute(TablesOrderScreen());
      case orderRoute:
        return _getPageRoute(OrderScreen());
      case foodRoute:
        return _getPageRoute(FoodsListScreen());
      default:
        return _getPageRoute(TableListScreen());
    }


}
PageRoute _getPageRoute(Widget child)=>MaterialPageRoute(builder: (context)=>child);