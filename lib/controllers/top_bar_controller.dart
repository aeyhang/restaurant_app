import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
class TopBarController extends GetxController{
  static TopBarController instance=Get.find();
  var showedWidget=Row().obs;
}

