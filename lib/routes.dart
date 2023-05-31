import 'package:flutter/material.dart';
import 'package:matching/model/food_model.dart';
import 'package:matching/model/recipe_model.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/screen/recipe_order_screen.dart';
import 'package:matching/representation/screen/recipe_screen.dart';
import 'package:matching/representation/screen/select_ingredients_recipe_screen.dart';
import 'package:matching/representation/screen/store_screen.dart';
import 'representation/screen/home_screen.dart';
import 'representation/screen/profile_screen.dart';
import 'representation/screen/login_screen.dart';

import 'representation/screen/intro_screen.dart';
import 'representation/screen/main_app.dart';
import 'representation/screen/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginPage.routeName: (context) => const LoginPage(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName:(context) => const ProfileScreen(),
  RecipeScreen.routeName: (context) => const RecipeScreen(),
  IngredientsInRecipeScreen.routeName: (context) => const IngredientsInRecipeScreen(),
  StoreScreen.routeName: (context) => const StoreScreen(),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RecipeDetailScreen.routeName:
      final dynamic arguments = settings.arguments;
      if (arguments is FoodModel) {
        final FoodModel foodModel = arguments;
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => RecipeDetailScreen(
            foodModel: foodModel,
          ),
        );
      }
      break;

    case RecipeOrderScreen.routeName:
      final String? destination = (settings.arguments as String?);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => RecipeOrderScreen(
          destination: destination,
        ),
      );
      
    default:
      return null;
  }
  return null;
}

