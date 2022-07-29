import 'dart:math';

import 'package:cookpad_flutter/pages/login_view.dart';
import 'package:cookpad_flutter/services/auth.dart';
import 'package:cookpad_flutter/themes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Spacer(),
            Text('Buat Akun',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Gilroy', color: blackColor)),
            const Spacer()
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: greyColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 100, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daftar',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  'Daftar Cookpad dan bagikan resep mu',
                  style: TextStyle(fontFamily: 'Gilroy', fontSize: 15),
                ),
                const Spacer(
                  flex: 2,
                ),
                // const Center(
                //   child: Image(
                //     image: AssetImage(
                //         'assets/images/src_assets_images_imgauthregister.png'),
                //     width: 250,
                //   ),
                // ),
                const Spacer(
                  flex: 2,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nama Lengkap',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Daftar'),
                      onPressed: () {
                        register();
                      },
                    )),
                const Spacer(
                  flex: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AuthenticationService service = AuthenticationService(FirebaseAuth.instance);

  Future<void> register() async {
    if (await service.signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text)) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("GAGAL REGISTER"),
        ),
      );
    }
  }
}
