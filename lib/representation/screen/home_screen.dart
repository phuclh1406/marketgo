import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';

import '../../services/user_service.dart';
import '../widgets/app_bar_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  // Widget getUserProfile() {
  //   return FutureBuilder(
  //     future: UserService.getUsers(), builder: (BuildContext context, AsyncSnapshot<dynamic> model) { if(model.hasData) {
  //       print()
  //     }},
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      implementLeading: true,
      implementTraling: true,
      child: Container(
        color: Colors.amber,
      ),
    );
  }
}
