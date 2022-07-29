import 'package:cookpad_flutter/api/firebase_api.dart';
import 'package:cookpad_flutter/models/recipe.dart';
import 'package:cookpad_flutter/pages/login_view.dart';
import 'package:cookpad_flutter/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:cookpad_flutter/widget/bottom_navigation.dart';
import 'package:cookpad_flutter/widget/recipe_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cookpad_flutter/themes/themes.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:cookpad_flutter/widget/alertBox.dart';
import 'package:provider/provider.dart';

import '../widget/bottomsheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  AuthenticationService service = AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        actions: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 25),
                child: const Icon(FeatherIcons.messageSquare, size: 25),
              ),
            ],
          ),
        ],
      ),
      body: const DesignBody(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class DesignBody extends StatelessWidget {
  const DesignBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 100,
              color: Colors.white12,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 360,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(200, 200, 200, 100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            hintText: 'Ketik bahan yang kamu punya...',
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                height: 1.4,
                                fontWeight: FontWeight.w300),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Mengikuti',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      Text('Inspirasi',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              )),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const Text(
                      'Siap-siap Buat Ramadhan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.only(left: 30, top: 20),
                  ),
                  Container(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      child: const Icon(
                        FeatherIcons.arrowRight,
                        size: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: StreamBuilder<List<Recipe>>(
                    stream: FirebaseApi.readRecipes(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return buildText('Something Went Wrong Try later');
                          } else {
                            final recipes = snapshot.data;

                            final provider =
                                Provider.of<RecipeProvider>(context);
                            provider.setRecipes(recipes!);

                            return RecipeListWidget();
                          }
                      }
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Text(
                  'Bahan Pilihan Untukmu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.only(left: 30, top: 50),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 30, top: 50),
                  child: const Icon(
                    FeatherIcons.arrowRight,
                    size: 20,
                    color: Colors.white,
                  )),
            ],
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 350,
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/ingredients.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
