import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/widgets/item_recipe_widget.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../model/recipe_model.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/mini_app_bar_container.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  static const String routeName = '/recipes_screen';

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // final List<RecipeModel> listRecipe = [
  //   RecipeModel(
  //     recipeImage: AssetHelper.food3,
  //     recipeName: 'Bún bò Huế',
  //     location: 'Món bún bò với hương vị truyền thống đặc trưng xứ Huế',
  //     awayKilometer: '364 m',
  //     star: 4.5,
  //     numberOfReview: 3241,
  //     price: 143,
  //   ),
  //   RecipeModel(
  //     recipeImage: AssetHelper.food2,
  //     recipeName: 'Hủ tíu Nam Vang',
  //     location: 'Món hủ tíu Nam Vang với hương vị truyền thống đặc trưng',
  //     awayKilometer: '2.3 km',
  //     star: 4.2,
  //     numberOfReview: 3241,
  //     price: 234,
  //   ),
  //   RecipeModel(
  //     recipeImage: AssetHelper.food4,
  //     recipeName: 'Cơm gà',
  //     location: 'Món cơm gà được chiên qua dầu và nước mắm',
  //     awayKilometer: '1.1 km',
  //     star: 3.8,
  //     numberOfReview: 1234,
  //     price: 132,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: 'Recipes',
      implementTraling: true,
      implementLeading: true,
      child: Column(children: [
        TextField(
          enabled: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Search your destination',
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.black,
                size: 14,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kItemPadding,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding),
          ),
          style: TextStyles.defaultStyle,
          onChanged: (value) {},
          onSubmitted: (String submitValue) {},
        ),
        const SizedBox(height: 10),
        // Expanded(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: listRecipe
        //           .map(
        //             (e) => ItemRecipeWidget(
        //               recipeModel: e,
        //               onTap: () {
        //                 Navigator.of(context).pushNamed(RecipeDetailScreen.routeName, arguments: e);
        //               },
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
