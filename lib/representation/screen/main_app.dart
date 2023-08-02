import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/cart_screen.dart';
import 'package:matching/representation/screen/order_history_screen.dart';
import 'package:matching/representation/screen/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

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
        children: const [
          HomeScreen(),
          NotificationScreen(),
          OrderHistoryScreen(),
          Profile(),
        ],
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
        margin: const EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.house,
                size: kDefaultIconSize,
              ),
              title: const Text('Trang chủ')),
              SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.solidBell,
                size: kDefaultIconSize,
              ),
              title: const Text('Thông báo')),
          SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.moneyBillTransfer,
                size: kDefaultIconSize,
              ),
              title: const Text('Lịch sử')),
          SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.solidUser,
                size: kDefaultIconSize,
              ),
              title: const Text('Cá nhân')),
        ],
      ),
    );
  }
}
