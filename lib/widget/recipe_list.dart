import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:cookpad_flutter/widget/recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final recipes = provider.recipes;

    return recipes.isEmpty
        ? Center(
            child: Text(
              'resep kosong',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return RecipeWidget(recipe: recipe);
            },
          );
  }
}
