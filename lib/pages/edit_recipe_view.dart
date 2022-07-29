import 'package:cookpad_flutter/models/recipe.dart';
import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:cookpad_flutter/widget/recipe_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  late String judul;
  late String bahan;
  late String langkah;

  @override
  void initState() {
    super.initState();

    judul = widget.recipe.judul;
    bahan = widget.recipe.bahan;
    langkah = widget.recipe.langkah;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Paket'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<RecipeProvider>(context, listen: false);
                provider.removeRecipe(widget.recipe);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: RecipeFormWidget(
              judul: judul,
              bahan: bahan,
              langkah: langkah,
              onChangedJudul: (judul) => setState(() => this.judul = judul),
              onChangedBahan: (bahan) => setState(() => this.bahan = bahan),
              onChangedLangkah: (langkah) =>
                  setState(() => this.langkah = langkah),
              onSavedRecipe: saveRecipe,
            ),
          ),
        ),
      );

  void saveRecipe() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<RecipeProvider>(context, listen: false);

      provider.updateRecipe(widget.recipe, judul, bahan, langkah);

      Navigator.of(context).pop();
    }
  }
}
