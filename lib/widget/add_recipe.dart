import 'package:cookpad_flutter/models/recipe.dart';
import 'package:cookpad_flutter/services/auth.dart';
import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:cookpad_flutter/widget/recipe_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecipeDialogWidget extends StatefulWidget {
  @override
  _AddRecipeDialogWidgetState createState() => _AddRecipeDialogWidgetState();
}

class _AddRecipeDialogWidgetState extends State<AddRecipeDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationService service = AuthenticationService(FirebaseAuth.instance);
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String judul = '';
  String bahan = '';
  String langkah = '';
  String penulis = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beli Paket',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot>(
                  future: users.doc(service.getUUID()).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    penulis = data['name'];
                    return RecipeFormWidget(
                      onChangedJudul: (judul) =>
                          setState(() => this.judul = judul),
                      onChangedBahan: (bahan) =>
                          setState(() => this.bahan = bahan),
                      onChangedLangkah: (langkah) =>
                          setState(() => this.langkah = langkah),
                      onSavedRecipe: addRecipe,
                    );
                  }),
            ],
          ),
        ),
      );

  void addRecipe() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final recipe = Recipe(
          penulis: penulis,
          judul: judul,
          bahan: bahan,
          langkah: langkah,
          id: DateTime.now().toString(),
          createdTime: DateTime.now());

      final provider = Provider.of<RecipeProvider>(context, listen: false);
      provider.addRecipe(recipe);
      Navigator.of(context).pop();
    }
  }
}
