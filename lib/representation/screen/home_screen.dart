import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/representation/screen/ingredients_screen.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/screen/recipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/category_model.dart';
import '../../model/food_model.dart';
import '../../model/recipe_model.dart';
import '../../model/user_model.dart';
import '../../services/category_service.dart';
import '../../services/food_service.dart';
import '../../services/user_service.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/categories_list_widget.dart';
import 'store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAPICallProcess = false;
  FoodModel? foodModel;
  UserModel? userModel;
  late List<CategoryModel> listCate;

  Future<String> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('user_name');
    return userName ?? ''; // Return an empty string if userName is null
  }
  Future<String> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? image = prefs.getString('avatar');
    return image ?? ''; // Return an empty string if userName is null
  }

  Widget loadFoodsLeft() {
    return FutureBuilder<List<FoodModel>?>(
      future: FoodService.getAllFoods(),
      builder:
          (BuildContext context, AsyncSnapshot<List<FoodModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<FoodModel>? foods = snapshot.data;

          if (foods != null && foods.isNotEmpty) {
            int loopCount =
                (foods.length / 2).floor(); // Calculate half of the foods length

            return Column(
              children: [
                for (var i = 0; i < loopCount; i++)
                  if (foods[i].foodName != null ||
                      foods[i].image![0].image != null)
                    _buildImageHomeScreen(
                        foods[i].foodName, foods[i].image![0].image)
              ],
            );
          } else {
            return const Text('No foods found.');
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

  Widget loadFoodsRight() {
    return FutureBuilder<List<FoodModel>?>(
      future: FoodService.getAllFoods(),
      builder:
          (BuildContext context, AsyncSnapshot<List<FoodModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<FoodModel>? foods = snapshot.data;

          if (foods != null && foods.isNotEmpty) {
            int startIndex =
                (foods.length / 2).ceil(); // Calculate half of the foods length

            return Column(
              children: [
                for (var i = startIndex; i < foods.length; i++)
                  if (foods[i].foodName != null ||
                      foods[i].image![0].image != null)
                    _buildImageHomeScreen(
                        foods[i].foodName, foods[i].image![0].image)
              ],
            );
          } else {
            return const Text('No foods found.');
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
      // onTap: () {
      //   Navigator.of(context)
      //       .pushNamed(RecipeDetailScreen.routeName, arguments: name);
      // },
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    child: Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      children: [
                        Text(
                          name!,
                          style: TextStyles.defaultStyle.bold,
                          maxLines: 2,
                        ),
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
    return AppBarContainerWidget(
      titleString: 'home',
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
        child: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Xin chào \n${snapshot.data!}!',
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
                  const SizedBox(
                    height: kMediumPadding,
                  ),
                  Text(
                    'Bạn đang cần gì?',
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
                child: FutureBuilder<String>(
                    future: getImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                          width: 10,
                          height: 10,
                        );
                      } else if (snapshot.hasError) {
                        return ImageHelper.loadFromAsset(AssetHelper.food1);
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
      implementLeading: false,
      child: Column(
        children: [
          TextField(
            enabled: true,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm công thức của bạn',
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
                }, 'Công thức'),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    const Icon(
                      FontAwesomeIcons.store,
                      weight: kDefaultPadding,
                    ),
                    const Color(0xffF77777), () {
                  Navigator.of(context).pushNamed(StoreScreen.routeName);
                }, 'Cửa hàng'),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    const Icon(
                      FontAwesomeIcons.carrot,
                      weight: kDefaultPadding,
                    ),
                    const Color(0xff3EC8BC),
                    () {Navigator.of(context).pushNamed(IngredientsScreen.routeName);},
                    'Nguyên Liệu'),
              ),
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Row(
            children: [
              Text(
                'Phổ biến',
                style: TextStyles.defaultStyle.bold,
              ),
              const Spacer(),
              Text(
                'Xem thêm',
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
                    Expanded(
                      child: Column(children: [loadFoodsLeft()]),
                    ),
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Expanded(
                      child: Column(children: [loadFoodsRight()]),
                    ),
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
