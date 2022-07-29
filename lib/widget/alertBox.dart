import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showAlertDialog(BuildContext context) {
  TextEditingController _editRecipe = TextEditingController();

  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _editRecipe,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    // hintText: recipe.listRecipe[recipe.selectedIndex!]['recipe']
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('UPDATE'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('DELETE'),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
