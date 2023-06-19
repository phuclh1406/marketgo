import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  static const String routeName = 'success_screen';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('PaymentSuccess'),);
  }
}