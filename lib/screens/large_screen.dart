import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/helpers/local_navigator.dart';
import 'package:restaurant_app/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          child: SideMenu(),
        ),
        Expanded(child: Container(
          child: localNavigator(),
        )),
      ],
    );
  }
}
