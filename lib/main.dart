import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matching/firebase_options.dart';
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
      home: const SplashScreen(),
      // home: FutureBuilder(
      //   future: Future.delayed(
      //       const Duration(seconds: 3)), // Adjust the duration as needed
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //     return const SplashScreen(); // Show SplashScreen during the delay
      //   } 

      //     return StreamBuilder<User?>(
      //       stream: FirebaseAuth.instance.authStateChanges(),
      //       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
      //         if (snapshot.hasError) {
      //           return Text(snapshot.error.toString());
      //         }

      //         if (snapshot.connectionState == ConnectionState.active) {
      //           if (snapshot.data == null) {
      //             return const LoginPage(); // Show LoginPage when the user is not authenticated
      //           } else {
      //             return const MainApp(); // Show MainApp when the user is authenticated
      //           }
      //         }

      //         return const SplashScreen(); // Show SplashScreen while waiting for the connection state
      //       },
      //     );
      //   },
      // ),
    );
  }
}
