import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookpad_flutter/models/recipe.dart';
import 'package:cookpad_flutter/utils.dart';

class FirebaseApi {
  static Future<String> createRecipe(Recipe recipe) async {
    final docRecipe = FirebaseFirestore.instance.collection('recipe').doc();

    recipe.id = docRecipe.id;
    await docRecipe.set(recipe.toJson());

    return docRecipe.id;
  }

  static Stream<List<Recipe>> readRecipes() => FirebaseFirestore.instance
      .collection('recipe')
      .orderBy(RecipeField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Recipe.fromJson));

  static Future updateRecipe(Recipe recipe) async {
    final docRecipe =
        FirebaseFirestore.instance.collection('recipe').doc(recipe.id);

    await docRecipe.update(recipe.toJson());
  }

  static Future deleteRecipe(Recipe recipe) async {
    final docRecipe =
        FirebaseFirestore.instance.collection('recipe').doc(recipe.id);

    await docRecipe.delete();
  }
}
