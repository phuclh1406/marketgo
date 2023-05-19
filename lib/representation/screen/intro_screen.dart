import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../widgets/button_widget.dart';
import 'main_app.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const routeName = 'intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<int> _pageStreamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  Widget _buildItemIntroScreen(String image, String title, String description,
      AlignmentGeometry alignment) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: alignment,
          child: ImageHelper.loadFromAsset(
            image,
            height: 480,
            fit: BoxFit.fitHeight
          ),
        ),
        const SizedBox(height: kMediumPadding * 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.defaultStyle.bold,
              ),
              const SizedBox(height: kMediumPadding / 2),
              Text(
                description,
                style: TextStyles.defaultStyle,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItemIntroScreen(
                  AssetHelper.intro1,
                  'Suggest dish by your budget',
                  'Need a dish with your specifically budget? Go now',
                  Alignment.center),
              _buildItemIntroScreen(
                  AssetHelper.intro2,
                  '100+ Recipe',
                  'The recipe is created by experienced chef',
                  Alignment.center),
              _buildItemIntroScreen(
                  AssetHelper.intro3,
                  'Got your ingredients by one click',
                  'Many ingredients are selled. Click and buy it!',
                  Alignment.center),
            ],
          ),
          Positioned(
              left: kMediumPadding,
              right: kMediumPadding,
              bottom: kMediumPadding * 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          dotWidth: kMinPadding,
                          dotHeight: kMinPadding,
                          activeDotColor: Colors.orange,
                        )),
                  ),
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: _pageStreamController.stream,
                    builder: (context, snapshot) {
                      return Expanded(
                        flex: 4,
                        child: ButtonWidget(
                          title: snapshot.data != 2 ? 'Next' : 'Get Started',
                          ontap: () {
                            if(_pageController.page != 2 ) {
                              _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                            } else {
                              Navigator.of(context).pushNamed(MainApp.routeName);
                            }
                            
                          }
                        ),
                      );
                    }
                  )
                ],
              ))
        ],
      ),
    );
  }
}
