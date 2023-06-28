import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/model/food_model.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/widgets/categories_list_widget.dart';
import 'package:matching/representation/widgets/item_recipe_widget.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../model/category_detail_model.dart';
import '../../model/category_model.dart';
import '../../services/category_detail_service.dart';
import '../../services/category_service.dart';
import '../../services/food_service.dart';
import '../widgets/mini_app_bar_container.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  static const String routeName = '/recipes_screen';

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool isAPICallProcess = false;
  String query = '';
  String category = '';
  var scrollController = ScrollController();
  Widget loadCategories() {
    return FutureBuilder<List<CategoryModel>?>(
      future: CategoryService.getAllCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<CategoryModel>? listCate = snapshot.data!;

          if (listCate.isNotEmpty) {
            return Row(
              children: [
                for (var i = 0; i < listCate.length; i++)
                  if (listCate[i].cateName != null)
                    CategoriesList(
                        cateName: listCate[i].cateName!, ontap: () {})
              ],
            );
          } else {
            return const Text('No category found.');
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

 Widget loadCategoriesDetail() {
  return FutureBuilder<List<CategoryDetailModel>?>(
    future: CategoryDetailService.getAllCategoriesDetailForFoods(),
    builder: (BuildContext context,
        AsyncSnapshot<List<CategoryDetailModel>?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the future to complete, display a loading indicator
        return const Text('');
      } else if (snapshot.hasData) {
        List<CategoryDetailModel>? listCateDetail = snapshot.data!;

        if (listCateDetail.isNotEmpty) {
          return Row(
            children: [
              CategoriesList(
                cateName: 'Tất cả',
                ontap: () {
                  setState(() {
                    category = '';
                  });
                },
              ),
              for (var i = 0; i < listCateDetail.length; i++)
                if (listCateDetail[i].cateDetailName != null)
                  CategoriesList(
                    cateName: listCateDetail[i].cateDetailName!,
                    ontap: () {
                      setState(() {
                        category = listCateDetail[i].cateDetailId!;
                      });
                    },
                  ),
            ],
          );
        } else {
          return const Text('No category found.');
        }
      } else if (snapshot.hasError) {
        // Display an error message if the future completed with an error
        return Text('Error: ${snapshot.error}');
      } else {
        return const SizedBox(); // Return an empty container or widget if data is null
      }
    },
  );
}


  Widget listRecipe(String value, String category) {
    if (value.isEmpty && category.isEmpty) {
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
              return Column(
                children: [
                  for (var i = 0; i < foods.length; i++)
                    if (foods[i].foodName != null ||
                        foods[i].image![0].image != null)
                      ItemRecipeWidget(
                        foodModel: foods[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RecipeDetailScreen.routeName,
                            arguments: foods[i],
                          );
                        },
                      ),
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
    } else if (value.isNotEmpty && category == null) {
      return FutureBuilder<List<FoodModel>?>(
        future: FoodService.getFoodsByName(value),
        builder:
            (BuildContext context, AsyncSnapshot<List<FoodModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<FoodModel>? foods = snapshot.data;

            if (foods != null && foods.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < foods.length; i++)
                    if (foods[i].foodName != null ||
                        foods[i].image![0].image != null)
                      ItemRecipeWidget(
                        foodModel: foods[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RecipeDetailScreen.routeName,
                            arguments: foods[i],
                          );
                        },
                      ),
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
    } else if (value.isEmpty) {
      return FutureBuilder<List<FoodModel>?>(
        future: FoodService.getFoodsByCategory(category),
        builder:
            (BuildContext context, AsyncSnapshot<List<FoodModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<FoodModel>? foods = snapshot.data;

            if (foods != null && foods.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < foods.length; i++)
                    if (foods[i].foodName != null ||
                        foods[i].image![0].image != null)
                      ItemRecipeWidget(
                        foodModel: foods[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RecipeDetailScreen.routeName,
                            arguments: foods[i],
                          );
                        },
                      ),
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
    } else {
      return FutureBuilder<List<FoodModel>?>(
        future: FoodService.getFoodsByNameAndCategory(value, category),
        builder:
            (BuildContext context, AsyncSnapshot<List<FoodModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<FoodModel>? foods = snapshot.data;

            if (foods != null && foods.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < foods.length; i++)
                    if (foods[i].foodName != null ||
                        foods[i].image![0].image != null)
                      ItemRecipeWidget(
                        foodModel: foods[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RecipeDetailScreen.routeName,
                            arguments: foods[i],
                          );
                        },
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MiniAppBarContainerWidget(
        titleString: 'Công thức',
        implementTraling: true,
        implementLeading: true,
        child: Column(children: [
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
            onSubmitted: (String value) {
              setState(() {
                query = value;
              });
            },
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                child: Row(
                  children: [
                    loadCategoriesDetail(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: ProgressHUD(
                inAsyncCall: isAPICallProcess,
                opacity: 0.3,
                key: UniqueKey(),
                child: Column(children: [
                  if (query.isEmpty && category.isEmpty)
                    listRecipe('', '')
                  else if (query.isNotEmpty && category.isEmpty)
                    listRecipe(query, '')
                  else
                    listRecipe(query, category)
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
