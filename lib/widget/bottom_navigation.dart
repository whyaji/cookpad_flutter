import 'package:cookpad_flutter/pages/profil_view.dart';
import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:cookpad_flutter/widget/add_recipe.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(width: 1),
            const IconButton(
                onPressed: null,
                icon: Icon(FeatherIcons.home, color: Colors.white)),
            const IconButton(
                onPressed: null,
                icon: Icon(FeatherIcons.search, color: Colors.white)),
            IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AddRecipeDialogWidget(),
                      barrierDismissible: false,
                    ),
                icon: Icon(FeatherIcons.plusSquare, color: Colors.white)),
            const IconButton(
                onPressed: null,
                icon: Icon(FeatherIcons.fileText, color: Colors.white)),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Profil();
                  }));
                },
                icon: const Icon(FeatherIcons.user, color: Colors.white)),
            const SizedBox(width: 1),
          ],
        ),
        color: Colors.white24,
      ),
    );
  }
}
