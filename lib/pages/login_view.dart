import 'package:cookpad_flutter/services/auth.dart';
import 'package:cookpad_flutter/pages/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cookpad_flutter/themes/themes.dart';
import 'home_view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const firstColor = Color.fromARGB(255, 0, 119, 255);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool remember = false;
  String name = '';

  @override
  void initState() {
    super.initState();
  }

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
                  'Masuk',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  'Login untuk lihat akun kamu yuk',
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
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
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
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Lupa Pasword?',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Masuk'),
                      onPressed: () {
                        login();
                      },
                    )),
                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: <Widget>[
                    const Text('Tidak punya akun?'),
                    TextButton(
                      child: const Text('Daftar Sekarang'),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const Register();
                        }));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
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

  Future<void> login() async {
    if (await AuthenticationService(FirebaseAuth.instance).signIn(
        email: nameController.text, password: passwordController.text)) {
      nameController.clear();
      passwordController.clear();
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("GAGAL LOGIN"),
        ),
      );
    }
  }
}
