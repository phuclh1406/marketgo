import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard(
      {super.key, required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onPressed,
      child: Card(
        // color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color.fromARGB(255, 240, 159, 52),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 240, 159, 52),
                  fontSize: 20,
                  fontFamily: "Source Sans Pro"),
            ),
          ),
        ),
      ),
    );
  }
}