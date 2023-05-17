import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/color_constants.dart';
import 'core/helper/local_storage_helper.dart';
import 'representation/screen/splash_screen.dart';
import 'routes.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
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
      home: const SplashScreen(),
    );
  }
}

