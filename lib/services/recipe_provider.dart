import 'package:cookpad_flutter/api/firebase_api.dart';
import 'package:cookpad_flutter/models/recipe.dart';
import 'package:flutter/cupertino.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes =>
      _recipes.where((recipe) => recipe.isDone == false).toList();

  List<Recipe> get recipesCompleted =>
      _recipes.where((recipe) => recipe.isDone == true).toList();

  void setRecipes(List<Recipe> recipes) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _recipes = recipes;
        notifyListeners();
      });

  void addRecipe(Recipe recipe) => FirebaseApi.createRecipe(recipe);

  void removeRecipe(Recipe recipe) => FirebaseApi.deleteRecipe(recipe);

  bool toggleRecipeStatus(Recipe recipe) {
    recipe.isDone = !recipe.isDone;
    FirebaseApi.updateRecipe(recipe);

    return recipe.isDone;
  }

  void updateRecipe(Recipe recipe, String judul, String bahan, String langkah) {
    recipe.judul = judul;
    recipe.bahan = bahan;
    recipe.langkah = langkah;

    FirebaseApi.updateRecipe(recipe);
  }
}
