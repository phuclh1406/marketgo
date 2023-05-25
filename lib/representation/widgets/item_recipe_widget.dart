import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/button_widget.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/recipe_model.dart';
import 'dash_line_widget.dart';

class ItemRecipeWidget extends StatelessWidget {
  const ItemRecipeWidget({
    Key? key,
    required this.recipeModel,
    this.onTap,
  }) : super(key: key);

  final RecipeModel recipeModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: kMediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(right: kDefaultPadding),
            
            child: ImageHelper.loadFromAsset(
              recipeModel.recipeImage,
              height: 200,
              fit: BoxFit.fitHeight,
              radius: const BorderRadius.only(
                topLeft: Radius.circular(
                  kDefaultPadding,
                ),
                bottomRight: Radius.circular(
                  kDefaultPadding,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeModel.recipeName,
                  style: TextStyles.defaultStyle.fontHeader.bold,
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Wrap(
                  children: [
                    const SizedBox(
                      width: kMinPadding,
                    ),
                    Text(
                      recipeModel.location,
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.star, weight:kDefaultPadding),
                    const SizedBox(
                      width: kMinPadding,
                    ),
                    Text(
                      recipeModel.star.toString(),
                    ),
                  ],
                ),
                const DashLineWidget(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${recipeModel.price.toString()}.000 vnđ',
                            style: TextStyles.defaultStyle.fontHeader.bold,
                          ),
                          const SizedBox(
                            height: kMinPadding,
                          ),
                          Text(
                            '/món',
                            style: TextStyles.defaultStyle.fontCaption,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        title: 'How to cook',
                        ontap: onTap,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
