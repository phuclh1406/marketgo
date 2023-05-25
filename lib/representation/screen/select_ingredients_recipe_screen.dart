import 'package:flutter/material.dart';
import 'package:matching/representation/widgets/item_select_ingredients.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../widgets/button_widget.dart';

class IngredientsInRecipeScreen extends StatefulWidget {
  const IngredientsInRecipeScreen({Key? key}) : super(key: key);

  static const String routeName = '/ingredients_in_recipe_screen';

  @override
  State<IngredientsInRecipeScreen> createState() => _IngredientsInRecipeScreenState();
}

class _IngredientsInRecipeScreenState extends State<IngredientsInRecipeScreen> {
  final Map<String, GlobalKey<SelectIngredientsInRecipeWidget>> _itemCountKeys = {
    'Gao': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'Ga': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'Toi': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'Mam': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'Dau': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'Dua': GlobalKey<SelectIngredientsInRecipeWidget>(),
    'CaChua': GlobalKey<SelectIngredientsInRecipeWidget>(),
  };

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      implementLeading: true,
      titleString: 'Select Ingredients',
      paddingContent: const EdgeInsets.all(kMediumPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kMediumPadding,
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Gao'],
              initData: 1,
              icon: AssetHelper.ingre1,
              value: 'Gạo Hoa Nắng',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Ga'],
              initData: 1,
              icon: AssetHelper.ingre2,
              value: 'Má đùi',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Toi'],
              initData: 1,
              icon: AssetHelper.ingre3,
              value: 'Tỏi',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Mam'],
              initData: 1,
              icon: AssetHelper.ingre4,
              value: 'Nước Mắm',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Dau'],
              initData: 1,
              icon: AssetHelper.ingre5,
              value: 'Dầu ăn',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['Dua'],
              initData: 1,
              icon: AssetHelper.ingre6,
              value: 'Dưa leo',
            ),
            SelectIngredientsInRecipe(
              key: _itemCountKeys['CaChua'],
              initData: 1,
              icon: AssetHelper.ingre7,
              value: 'Cà chua',
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(
              title: 'Done',
              ontap: () {
                Navigator.of(context).pop([
                  _itemCountKeys['Gao']!.currentState!.number,
                  _itemCountKeys['Ga']!.currentState!.number,
                  _itemCountKeys['Toi']!.currentState!.number,
                  _itemCountKeys['Mam']!.currentState!.number,
                  _itemCountKeys['Dau']!.currentState!.number,
                  _itemCountKeys['Dua']!.currentState!.number,
                  _itemCountKeys['CaChua']!.currentState!.number,
                ]);
              },
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
