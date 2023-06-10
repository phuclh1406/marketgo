import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static const String routeName = "/order";

  @override
  Widget build(BuildContext context) {
    return const MiniAppBarContainerWidget(
      titleString: "Order History",
      implementLeading: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.sort,
                  color: Colors.black45,
                ),
                Text(
                  "Sort",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}
