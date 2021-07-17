import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

AppBar topBar({required BuildContext context}) {
  return AppBar(
    toolbarHeight: 75,
    leadingWidth: 300,
    leading: Row(
      children: [
Container(
            height: 60,
            padding: const EdgeInsets.all(6),
            child: Image.asset('assets/images/restaurant.png')),
         CustomText(
          text: 'ຮ້ານອາຫານ ຂ້າງຂອງ',
          color: Colors.white,
          size: 28,
          weight: FontWeight.w300,
        ),
      ],
    ),
    backgroundColor: dark,
  );
}
