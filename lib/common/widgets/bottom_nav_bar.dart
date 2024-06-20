import 'package:customer_application/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavBar extends StatelessWidget {
  final int initialIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({this.initialIndex = 0, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.textPrimaryColor,
      color: AppColors.textPrimaryColor,
      animationDuration: Duration(milliseconds: 500),
      items: <Widget>[
        Icon(Icons.home, size: 26, color: Colors.white),
        Icon(Icons.shopping_cart, size: 26, color: Colors.white),
        Icon(Icons.payments_sharp, size: 26, color: Colors.white),
        Icon(Icons.shopping_basket,size: 26,color: Colors.white,),
      //  Icon(Icons.settings, size: 26, color: Colors.white),
      ],
      index: initialIndex,
      onTap: onTap,
    );
  }
}
