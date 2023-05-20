import 'package:flutter/material.dart';
import 'representation/screen/home_screen.dart';
import 'representation/screen/profile_screen.dart';
import 'representation/screen/login_screen.dart';

import 'representation/screen/intro_screen.dart';
import 'representation/screen/main_app.dart';
import 'representation/screen/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginPage.routeName: (context) => const LoginPage(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName:(context) => const ProfileScreen(),
  
  
};
