import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/home_screen.dart';
import 'package:matching/representation/screen/main_app.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';

class MiniAppBarContainerWidget extends StatelessWidget {
  const MiniAppBarContainerWidget({
    super.key,
    required this.child,
    this.title,
    this.implementLeading = false,
    this.titleString,
    this.subTitleString,
    this.implementTraling = false,
    this.paddingContent = const EdgeInsets.symmetric(
      horizontal: kMediumPadding,
    ),
  });

  final Widget child;
  final Widget? title;
  final String? titleString;
  final String? subTitleString;
  final bool implementLeading;
  final bool implementTraling;
  final EdgeInsets? paddingContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 100,
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 90,
            backgroundColor: ColorPalette.backgorundScaffoldColor,
            title: title ??
                Row(
                  children: [
                    if (implementLeading)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(kItemPadding),
                          child: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titleString ?? '',
                              style: TextStyles
                                  .defaultStyle.fontHeader.whiteTextColor.bold,
                            ),
                            if (subTitleString != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: kMediumPadding),
                                child: Text(
                                  subTitleString!,
                                  style: TextStyles
                                      .defaultStyle.fontCaption.whiteTextColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (implementTraling)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(MainApp.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(kItemPadding),
                          child: const Icon(
                            FontAwesomeIcons.house,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: Gradients.defaultGradientBackground,
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
          margin: const EdgeInsets.only(top: 110),
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          child: child,
        ),
      ],
    ));
  }
}
