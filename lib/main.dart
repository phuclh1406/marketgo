import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matching/firebase_options.dart';
import 'package:matching/representation/screen/cart_screen.dart';
import 'package:matching/representation/screen/check_out_screen.dart';
import 'package:matching/representation/screen/intro_screen.dart';
import 'package:matching/representation/screen/login_screen.dart';
import 'package:matching/representation/screen/main_app.dart';

import 'core/constants/color_constants.dart';
import 'core/helper/local_storage_helper.dart';
import 'representation/screen/splash_screen.dart';
import 'routes.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgorundScaffoldColor,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: const CartScreen(),

    );
  }
}
