import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = "/cart_screen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.yellowColor,
      body: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(30),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 100,
                width: 400,
                color: Colors.amber[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );
            }),
      ),
    );
  }
}
