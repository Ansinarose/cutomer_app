// ignore_for_file: unused_element, unused_import

import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/features/basket/views/basket_screen.dart';
import 'package:customer_application/features/cart/views/cart_screen.dart';
import 'package:customer_application/features/home/views/home_screen.dart';
import 'package:customer_application/features/payment/views/payment_history_screen.dart';
import 'package:customer_application/features/payment/views/payment_screen.dart';
import 'package:customer_application/features/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({this.initialIndex = 0, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onNavBarItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>ProfileScreen()
          )
        );
       break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BasketScreen()),
        );
        break;
      default:
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.textPrimaryColor,
      color: AppColors.textPrimaryColor,
      animationDuration: Duration(milliseconds: 500),
      items: <Widget>[
        Icon(Icons.home, size: 26, color: Colors.white),
        Icon(Icons.shopping_cart, size: 26, color: Colors.white,),
        Icon(Icons.settings, size: 26, color: Colors.white),
        Icon(Icons.shopping_basket,size: 26,color: Colors.white,),
      //  Icon(Icons.settings, size: 26, color: Colors.white),
      ],
      index: widget.initialIndex,
      onTap: widget.onTap
    );
  }

   
}
