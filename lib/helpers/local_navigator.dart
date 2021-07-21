import 'package:flutter/widgets.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/routing/router.dart';
import 'package:restaurant_app/routing/routes.dart';

Navigator localNavigator()=>Navigator(
  key: navigationController.navigationKey,
  initialRoute: tablesOrderRoute,
  onGenerateRoute: generateRoute,  
);