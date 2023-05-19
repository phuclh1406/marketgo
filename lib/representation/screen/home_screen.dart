import 'package:flutter/material.dart';

import '../widgets/app_bar_container.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'login_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      child: Container(
        color: Colors.amber,
      ),
    );
  }
}