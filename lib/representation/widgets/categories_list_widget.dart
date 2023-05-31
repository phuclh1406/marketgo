import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:matching/model/category_model.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../services/category_service.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.cateName, this.ontap});

  final String cateName;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: GestureDetector(
          onTap: ontap,
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(cateName, style: TextStyles.defaultStyle.regular)),
        ));
  }
}
