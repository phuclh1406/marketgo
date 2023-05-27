import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/screen/recipe_order_screen.dart';
import 'package:matching/representation/screen/recipe_screen.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/food_model.dart';
import '../../model/recipe_model.dart';
import '../../services/recipe_service.dart';
import '../../services/user_service.dart';
import '../widgets/app_bar_container.dart';
import 'store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAPICallProcess = false;
  RecipeModel? recipeModel;

  void initState() {
    super.initState();
    recipeModel = RecipeModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        recipeModel = arguments["model"];

        // Set the id value from the arguments map directly to recipeModel's id
        recipeModel!.foodModel?.foodId = arguments["food_id"];
        setState(() {});
      }
    });
  }

  Widget loadRecipesLeft() {
    return FutureBuilder<List<RecipeModel>?>(
      future: RecipeService.getAllRecipes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<RecipeModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<RecipeModel>? recipes = snapshot.data;

          if (recipes != null && recipes.isNotEmpty) {
            int loopCount = (recipes.length / 2)
                .ceil(); // Calculate half of the recipes length

            return Column(
              children: [
                for (var i = 0; i < loopCount; i++)
                  if (recipes[i].foodModel?.foodName != null ||
                      recipes[i].foodModel?.image != null)
                    _buildImageHomeScreen(recipes[i].foodModel!.foodName!,
                        recipes[i].foodModel!.image!)
              ],
            );
          } else {
            return const Text('No recipes found.');
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

  Widget loadRecipesRight() {
    return FutureBuilder<List<RecipeModel>?>(
      future: RecipeService.getAllRecipes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<RecipeModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<RecipeModel>? recipes = snapshot.data;

          if (recipes != null && recipes.isNotEmpty) {
            int startIndex =
                (recipes.length / 2).ceil(); // Calculate the starting index

            return Column(
              children: [
                for (var i = startIndex; i < recipes.length; i++)
                  if (recipes[i].foodModel?.foodName != null ||
                      recipes[i].foodModel?.image != null)
                    _buildImageHomeScreen(recipes[i].foodModel!.foodName!,
                        recipes[i].foodModel!.image!)
              ],
            );
          } else {
            return const Text('No recipes found.');
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

  Widget _buildItemCategory(
      Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: kMediumPadding,
            ),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kItemPadding)),
            child: icon,
          ),
          const SizedBox(
            height: kItemPadding,
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget _buildImageHomeScreen(String? name, String? image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RecipeDetailScreen.routeName, arguments: name);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ImageHelper.loadFromAsset(
              image!,
              height: 200,
              fit: BoxFit.fitHeight,
              radius: BorderRadius.circular(kItemPadding),
            ),
            const Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: TextStyles.defaultStyle.whiteTextColor.bold,
                  ),
                  const SizedBox(
                    height: kItemPadding,
                  ),
                  Container(
                    padding: const EdgeInsets.all(kMinPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFC107),
                        ),
                        SizedBox(
                          width: kItemPadding,
                        ),
                        Text('4.5')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBarContainerWidget(
      titleString: 'home',
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi James!',
                    style:
                        TextStyles.defaultStyle.fontHeader.whiteTextColor.bold),
                const SizedBox(
                  height: kMediumPadding,
                ),
                Text(
                  'Where are you going next?',
                  style: TextStyles.defaultStyle.fontCaption.whiteTextColor,
                )
              ],
            ),
            const Spacer(),
            const Icon(
              FontAwesomeIcons.bell,
              size: kDefaultIconSize,
              color: Colors.white,
            ),
            const SizedBox(
              width: kMinPadding,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  kItemPadding,
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(kItemPadding),
              child: ImageHelper.loadFromAsset(
                AssetHelper.intro1,
              ),
            ),
          ],
        ),
      ),
      implementLeading: false,
      child: Column(
        children: [
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
          const SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              Expanded(
                child: _buildItemCategory(
                    const Icon(
                      FontAwesomeIcons.book,
                      weight: kDefaultPadding,
                    ),
                    const Color(0xffFE9C5E), () {
                  Navigator.of(context).pushNamed(RecipeScreen.routeName);
                }, 'Recipes'),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    const Icon(
                      FontAwesomeIcons.store,
                      weight: kDefaultPadding,
                    ),
                    const Color(0xffF77777),
                    () {Navigator.of(context).pushNamed(StoreScreen.routeName);},
                    'Stores'),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    const Icon(
                      FontAwesomeIcons.carrot,
                      weight: kDefaultPadding,
                    ),
                    const Color(0xff3EC8BC),
                    () {},
                    'Ingredients'),
              ),
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Row(
            children: [
              Text(
                'Popular Destinations',
                style: TextStyles.defaultStyle.bold,
              ),
              const Spacer(),
              Text(
                'See All',
                style: TextStyles.defaultStyle.bold.primaryTextColor,
              ),
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ProgressHUD(
                inAsyncCall: isAPICallProcess,
                opacity: 0.3,
                key: UniqueKey(),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: Column(children: [loadRecipesLeft()]),
                    // ),
                    // const SizedBox(
                    //   width: kDefaultPadding,
                    // ),
                    // Expanded(
                    //   child: Column(children: [loadRecipesRight()]),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
