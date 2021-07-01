import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/helpers/responsiveness.dart';
import 'package:restaurant_app/routing/routes.dart';
import 'package:restaurant_app/widgets/site_menu_items.dart';

import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          Divider(
            color: light.withOpacity(0.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map(
                  (itemName) => SideMenuItems(
                      itemName: itemName == AuthenticationPageRoute
                          ? 'Log Out'
                          : itemName,
                      onTap: () {
                        if (itemName == AuthenticationPageRoute) {
                          //do something
                        }
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context))
                            Get.back();
                          navigationController.navigateTo(itemName);
                        }
                      }),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
