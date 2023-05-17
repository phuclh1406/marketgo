import 'package:flutter/material.dart';
import 'package:matching/representation/screen/login_screen.dart';

import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../core/helper/local_storage_helper.dart';
import 'intro_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(LoginPage.routeName);
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ImageHelper.loadFromAsset(AssetHelper.imageBackGroundSplash,
                fit: BoxFit.fitWidth)),
        Positioned.fill(
            child: ImageHelper.loadFromAsset(AssetHelper.imageCircleSplash)),
      ],
    );
  }
}
