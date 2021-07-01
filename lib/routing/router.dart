
import 'package:flutter/material.dart';
import 'package:restaurant_app/routing/routes.dart';
import 'package:restaurant_app/screens/order_screens/order_screen.dart';
import 'package:restaurant_app/screens/table_screens/tables_order_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case TablesOrderRoute:
        return _getPageRoute(TablesOrderScreen());
      case OrderRoute:
        return _getPageRoute(OrderScreen());
      case ClientsPageRoute:
        return _getPageRoute(TablesOrderScreen());
      default:
        return _getPageRoute(TablesOrderScreen());
    }


}
PageRoute _getPageRoute(Widget child)=>MaterialPageRoute(builder: (context)=>child);