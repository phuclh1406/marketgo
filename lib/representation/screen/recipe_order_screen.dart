import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/select_ingredients_recipe_screen.dart';
import 'package:matching/representation/widgets/item_select_ingredients.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../widgets/button_widget.dart';
import '../widgets/item_option_ingredients.dart';
import '../widgets/mini_app_bar_container.dart';

class RecipeOrderScreen extends StatefulWidget {
  const RecipeOrderScreen({Key? key, this.destination}) : super(key: key);

  static const routeName = '/recipe_order_screen';

  final String? destination;

  @override
  State<RecipeOrderScreen> createState() => _RecipeOrderScreenState();
}

class _RecipeOrderScreenState extends State<RecipeOrderScreen> {
  String? selectDate;
  String? guestAndRoom;

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      implementLeading: true,
      titleString: 'Store and Ingredients',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemOptionsIngredientsWidget(
              key: const ValueKey('store'),
              title: 'Cửa hàng',
              value: widget.destination ?? 'Minh Long',
              icon: const Icon(FontAwesomeIcons.store),
              onTap: () {},
            ),
            ItemOptionsIngredientsWidget(
              key: const ValueKey('ingredients'),
              title: 'Nguyên liệu',
              value: guestAndRoom ?? 'Nhấn để chọn',
              icon: const Icon(FontAwesomeIcons.carrot),
              onTap: () {
                Navigator.of(context).pushNamed(IngredientsInRecipeScreen.routeName);
              },
            ),
            ButtonWidget(
              title: 'Checkout',
              ontap: () {
                //Navigator.of(context).pushNamed(HotelsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
