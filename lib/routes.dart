import 'package:flutter/material.dart';
import 'package:matching/representation/screen/cart_screen.dart';
import 'representation/screen/check_out_screen.dart';
import 'package:matching/representation/screen/home_screen.dart';
import 'representation/screen/login_screen.dart';

import 'representation/screen/intro_screen.dart';
import 'representation/screen/main_app.dart';
import 'representation/screen/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginPage.routeName: (context) => const LoginPage(),
  CheckOutScreen.routeName: (context) => const CheckOutScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  
  
};
