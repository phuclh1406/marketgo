import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/model/category_model.dart';
import 'package:matching/model/ingredient_model.dart';
import 'package:matching/representation/widgets/ingredient_item_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/category_service.dart';
import 'package:matching/services/ingredient_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../widgets/categories_list_widget.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  static const String routeName = '/ingredients_screen';

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  bool isAPICallProcess = false;
  String query = '';
  String category = '';
  IngredientModel? ingredientModel;
  Widget listIngredients(String value, String category) {
    if (value.isEmpty && category.isEmpty) {
      return FutureBuilder<List<IngredientModel>?>(
        future: IngredientsService.getAllIngredients(),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   RecipeDetailScreen.routeName,
                          //   arguments: ingredients[i],
                          // );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    } else if (value.isNotEmpty && category.isEmpty) {
      return FutureBuilder<List<IngredientModel>?>(
        future: IngredientsService.getIngredientsByName(value),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   RecipeDetailScreen.routeName,
                          //   arguments: ingredients[i],
                          // );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    } else {
      return (const Text('123'));
    }
  }

  Widget loadCategories() {
    return FutureBuilder<List<CategoryModel>?>(
      future: CategoryService.getAllCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>?> snapshot) {
        if (snapshot.hasData) {
          List<CategoryModel>? listCate = snapshot.data!;

          if (listCate.isNotEmpty) {
            return Row(
              children: [
                for (var i = 0; i < listCate.length; i++)
                  if (listCate[i].cateName != null)
                    CategoriesList(
                        cateName: listCate[i].cateName!,
                        ontap: () {
                          setState(() {
                            category = listCate[i].cateId!;
                          });
                        })
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

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: 'Danh sách nguyên liệu',
      implementTraling: true,
      implementLeading: true,
      child: Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            onSubmitted: (String submitValue) {
              setState(() {
                query = submitValue;
              });
            },
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Row(
                    children: [
                      loadCategories(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ProgressHUD(
                        inAsyncCall: isAPICallProcess,
                        opacity: 0.3,
                        key: UniqueKey(),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(children: [
                                if (query.isEmpty && category.isEmpty)
                                  listIngredients('', '')
                                else if (query.isNotEmpty && category.isEmpty)
                                  listIngredients(query, '')
                                // else
                                //   listIngredients(query, category)
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
