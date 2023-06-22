import 'package:flutter/material.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';

class IngredientItemDetailWidget extends StatelessWidget {
  const IngredientItemDetailWidget({super.key, required this.description, required this.title});

  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 140,
            height: 50,
            padding:  const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 208, 208),
              
            ),
            child: Text(
              title,
              style: TextStyles.defaultStyle.bold,
            )),
        Container(
          width: 160,
          height: 50,
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 240, 237, 237),

          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                description,
                style: TextStyles.defaultStyle,
              ),
          )
        )
      ],
    );
  }
}
