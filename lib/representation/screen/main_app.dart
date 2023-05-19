import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
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
      appBar: AppBar(
        title: const Text('Logout'),
        actions: [
          IconButton(onPressed: () async {
            await GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.power_settings_new))
        ]
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children:[
          const HomeScreen(),
          Container(color: Colors.blue,),
          Container(color: Colors.red,),
          Container(color: Colors.yellow,),
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
            title: const Text('Home')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidHeart,
              size: kDefaultIconSize,
            ), 
            title: const Text('Likes')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.briefcase,
              size: kDefaultIconSize,
            ), 
            title: const Text('Booking')
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultIconSize,
            ), 
            title: const Text('Profile')
          ),
        ],
      ),
    );
  }
}
