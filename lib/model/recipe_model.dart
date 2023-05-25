class RecipeModel {
  RecipeModel({
    required this.recipeImage,
    required this.recipeName,
    required this.location,
    required this.awayKilometer,
    required this.star,
    required this.numberOfReview,
    required this.price,
  });

  final String recipeImage;
  final String recipeName;
  final String location;
  final String awayKilometer;
  final double star;
  final int numberOfReview;
  final int price;
}
