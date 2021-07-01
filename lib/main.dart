import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/controllers/navigation_controller.dart';
import 'package:restaurant_app/controllers/table_controller.dart';
import 'package:restaurant_app/layout.dart';

import 'controllers/menu_controller.dart';

void main() {
  Get.put(MenuController());
  Get.put(TableController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Phetsarath',
        pageTransitionsTheme:const PageTransitionsTheme(builders: {
          TargetPlatform.android:FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS:FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows:FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: LayOut(),
    );
  }
}
