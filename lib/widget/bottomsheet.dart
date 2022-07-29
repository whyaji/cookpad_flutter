import 'package:cookpad_flutter/widget/add_recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bottomSheet(BuildContext context) {
  TextEditingController _recipe = TextEditingController();

  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      color: Colors.black,
      child: Container(
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  "Add Recipes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(child: AddRecipeDialogWidget())
          ],
        ),
      ),
    ),
  );
}
