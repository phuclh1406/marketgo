import 'package:flutter/material.dart';
import 'package:matching/core/constants/textstyle_constants.dart';
import 'package:matching/model/cart.dart';
import '../widgets/mini_app_bar_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const String routeName = "/notification";

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with WidgetsBindingObserver {
  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: "Thông báo",
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Chưa có thông báo mới', style: TextStyles.defaultStyle.regular)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
