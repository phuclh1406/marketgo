import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/button_widget.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/image_helper.dart';
import '../../model/food_model.dart';
import '../../model/recipe_model.dart';
import 'dash_line_widget.dart';

class ItemRecipeWidget extends StatelessWidget {
  const ItemRecipeWidget({
    Key? key,
    required this.foodModel,
    this.onTap,
  }) : super(key: key);

  final FoodModel foodModel;
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
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  kDefaultPadding,
                ),
                topRight: Radius.circular(
                  kDefaultPadding,
                ),
              ),
              child: Image.network(
                foodModel.image![0].image!,
                width: 100,
                fit: BoxFit.fitWidth,
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        foodModel.foodName!,
                        style: TextStyles.defaultStyle.fontHeader.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(kMinPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kMinPadding),
                              color:
                                 const Color.fromARGB(255, 212, 204, 204).withOpacity(0.4),
                            ),
                            
                              child: Text(
                                'Phân loại: ${foodModel.categoryDetailModel!.cateDetailName!}',
                                style: TextStyles.defaultStyle.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                          
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Wrap(
                  children: [
                    const SizedBox(
                      width: kMinPadding,
                    ),
                    Text(foodModel.description!,
                        style: TextStyles.defaultStyle.subTitleTextColor),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(kMinPadding + 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kMinPadding),
                              color:
                                 const Color.fromARGB(255, 163, 235, 166).withOpacity(0.4),
                            ),
                            
                              child: Text(
                                'Dành cho: ${foodModel.quantitative!}',
                                style: TextStyles.defaultStyle.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                          
                          ),
                        ),
                  ],
                ),
                const DashLineWidget(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: kMinPadding,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        title: 'Xem cách chế biến',
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
