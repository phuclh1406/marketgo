import 'package:flutter/material.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';

class ButtonMomoWidget extends StatelessWidget {
  const ButtonMomoWidget({super.key, required this.title, this.ontap});

  final String title;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink.shade700
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyles.defaultStyle.bold.whiteTextColor)
      ),
    );
  }
}