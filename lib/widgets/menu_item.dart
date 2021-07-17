import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class MenuItem extends StatelessWidget {
  final String itemName;
  final IconData icon;
  final VoidCallback onTap;
  const MenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover('not hovering');
      },
      child: Container(
        color: menuController.isHovering(itemName)
            ? light.withOpacity(0.1)
            : Colors.transparent,
        child: Row(
          children: [
            Visibility(
              visible: menuController.isHovering(itemName) ||
                  menuController.isActive(itemName),
              child: Container(
                width: 6,
                height: 40,
                color: dark,
              ),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
            ),
            const SizedBox(width: 28,),
            Icon(icon),            
                if (!menuController.isActive(itemName))
                  Flexible(
                    child: CustomText(
                      text: itemName,
                      color:menuController.isHovering(itemName)?dark:light,
                    ),
                  )
                  else
                  Flexible(child: CustomText(
                    text: itemName,
                    color: dark,
                    size: 18,
                    weight: FontWeight.bold,
                  ),),

          ],
        ),
      ),
    );
  }
}
