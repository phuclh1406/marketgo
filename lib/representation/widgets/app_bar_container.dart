import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';


class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 186,
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 90,
            backgroundColor: ColorPalette.backgorundScaffoldColor,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: Gradients.defaultGradientBackground,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(35)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,

                  child: ImageHelper.loadFromAsset(AssetHelper.oval_1),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ImageHelper.loadFromAsset(AssetHelper.oval_2),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 156),
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          child: child,
        ),
      ],
    ));
  }
}
