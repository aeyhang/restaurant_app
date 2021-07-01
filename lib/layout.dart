import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/screens/large_screen.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class LayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 60,
                    padding: const EdgeInsets.all(6),
                    child: Image.asset('assets/images/restaurant.png')),
                const CustomText(
                  text: 'ຮ້ານອາຫານ ຂ້າງຂອງ',
                  color: Colors.white,
                  size: 28,
                  weight: FontWeight.w300,
                ),
              ],
            ),
          
          backgroundColor: dark,
        ),
        body: LargeScreen());
  }
}
