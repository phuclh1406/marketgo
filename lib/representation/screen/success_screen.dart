import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  static const String routeName = 'success_screen';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('PaymentSuccess'),);
  }
}