import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/core/helper/asset_helper.dart';
import 'package:matching/core/helper/image_helper.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';

import '../widgets/button_widget.dart';
import 'main_app.dart';

class MomoScreen extends StatelessWidget {
  const MomoScreen({super.key});
  static const String routeName = "/momo";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MiniAppBarContainerWidget(
          titleString: 'Thanh toán',
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: kMediumPadding / 2),
            const Text(
              "Thanh toán qua số tài khoản momo",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: kMediumPadding / 2),
            ImageHelper.loadFromAsset(AssetHelper.momo),
            const SizedBox(height: kMediumPadding / 2),
            Container(
              padding: const EdgeInsets.all(kMinPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kMinPadding),
                color:
                    const Color.fromARGB(255, 233, 228, 228).withOpacity(0.4),
              ),
              child: const Column(children: [
                Text(
                  'Thanh toán theo cú pháp: Email + BK',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: kMediumPadding / 2),
                Text(
                  'Ví dụ: phuclh14@gmail.com + BK',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: kDefaultPadding),
            ButtonWidget(
              title: "Hoàn tất thanh toán",
              ontap: () {
                Navigator.of(context).pushNamed(MainApp.routeName);
              },
            ),
          ])),
    );
  }
}
