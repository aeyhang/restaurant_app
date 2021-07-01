import 'package:flutter/material.dart';
import 'package:restaurant_app/helpers/responsiveness.dart';
import 'package:restaurant_app/widgets/horizontal_menu_item.dart';

class SideMenuItems extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const SideMenuItems({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // if (ResponsiveWidget.isCustomScreen(context))
    //   return VerticalMenuItem(itemName: itemName, onTap: onTap);
    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
