import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/routing/routes.dart';

class MenuController extends GetxController{
  static MenuController instance=Get.find();
  var activeItem=tablesOrderRoute.obs;
  var hoverItem="".obs;

  changeActiveItemTo(String itemName){
    activeItem.value=itemName;
  }  
  onHover(String itemName){
    if(!isActive(itemName))hoverItem.value=itemName;
  }
  isActive(String itemName)=>activeItem.value==itemName;
  isHovering(String itemName)=>hoverItem.value==itemName;

  Widget returnIconFor(String itemName){
    switch (itemName) {
      case tablesOrderRoute:
        return _customIcon(Icons.trending_up, itemName);
      case orderRoute:
        return _customIcon(Icons.drive_eta, itemName);
      case foodRoute:
        return _customIcon(Icons.settings, itemName);
      case tableRoute:
        return _customIcon(Icons.settings, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName){
    if(isActive(itemName))return Icon(icon,size: 28,color: dark,);
    return Icon(icon,color: isHovering(itemName)?dark:light,);
  }
}