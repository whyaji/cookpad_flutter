import 'package:cookpad_flutter/models/recipe.dart';
import 'package:cookpad_flutter/pages/edit_recipe_view.dart';
import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:cookpad_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeWidget({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => editInternetRecipe(context, recipe),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.penulis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: 150,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/default.png'),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        recipe.judul,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 90)),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  )),
            ],
          ),
        ),
        // Container(
        //   color: Colors.white,
        //   padding: EdgeInsets.all(20),
        //   child:
        // Row(
        //   children: [
        //     const SizedBox(width: 20),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             recipe.judul,
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Theme.of(context).primaryColor,
        //               fontSize: 22,
        //             ),
        //           ),
        //           if (recipe.penulis.isNotEmpty)
        //             Container(
        //               margin: EdgeInsets.only(top: 4),
        //               child: Text(
        //                 recipe.penulis,
        //                 style: TextStyle(fontSize: 20, height: 1.5),
        //               ),
        //             ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // ),
      );

  void deleteInternetRecipe(BuildContext context, Recipe recipe) {
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    provider.removeRecipe(recipe);

    Utils.showSnackBar(context, 'Paket Dihapus');
  }

  void editInternetRecipe(BuildContext context, Recipe recipe) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditRecipePage(recipe: recipe),
        ),
      );
}
