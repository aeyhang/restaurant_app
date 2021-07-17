import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/screens/large_screen.dart';
import 'package:restaurant_app/top_bar.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class LayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar(context: context,),
        body: LargeScreen());
  }
}
