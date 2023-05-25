import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matching/representation/screen/profile.dart';
import 'package:matching/representation/screen/profile_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const routeName = 'main_app';

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children:[
          const HomeScreen(),
          const CartScreen(),
          Container(color: Colors.red,),
          const Profile(),
        ]
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
        margin: const EdgeInsets.symmetric(horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.house,
              size: kDefaultIconSize,
            ), 
            title: const Text('Trang chủ')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.cartShopping,
              size: kDefaultIconSize,
            ), 
            title: const Text('Giỏ hàng')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.moneyBillTransfer,
              size: kDefaultIconSize,
            ), 
            title: const Text('Lịch sử')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultIconSize,
            ), 
            title: const Text('Cá nhân')
          ),
        ],
      ),
    );
  }
}
