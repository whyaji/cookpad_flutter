import 'package:flutter/material.dart';
import '../themes/themes.dart';

class RecipeFormWidget extends StatelessWidget {
  final String judul;
  final String bahan;
  final String langkah;
  final ValueChanged<String> onChangedJudul;
  final ValueChanged<String> onChangedBahan;
  final ValueChanged<String> onChangedLangkah;
  final VoidCallback onSavedRecipe;

  const RecipeFormWidget({
    Key? key,
    this.judul = '',
    this.bahan = '',
    this.langkah = '',
    required this.onChangedJudul,
    required this.onChangedBahan,
    required this.onChangedLangkah,
    required this.onSavedRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildJudul(),
            SizedBox(height: 8),
            buildBahan(),
            SizedBox(height: 8),
            buildLangkah(),
            SizedBox(height: 8),
            buildButton(),
          ],
        ),
      );

  Widget buildJudul() => TextFormField(
        initialValue: judul,
        onChanged: onChangedJudul,
        validator: (judul) {
          if (judul!.isEmpty) {
            return 'Nama tidak boleh kosong';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Judul',
        ),
      );

  Widget buildBahan() => TextFormField(
        initialValue: bahan,
        onChanged: onChangedBahan,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Bahan',
        ),
      );

  Widget buildLangkah() => TextFormField(
        initialValue: langkah,
        onChanged: onChangedLangkah,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Langkah-langkah',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(orangeColor),
          ),
          onPressed: onSavedRecipe,
          child: Text('Publish'),
        ),
      );
}
