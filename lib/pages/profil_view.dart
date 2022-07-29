import 'package:cookpad_flutter/pages/login_view.dart';
import 'package:cookpad_flutter/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FeatherIcons.arrowLeft,
            color: Colors.white,
          ),
        ),
        title: const Text('Pengaturan',
            style: TextStyle(fontSize: 18, color: Colors.white)),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white12),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
              child: SizedBox(
                height: 100,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle_rounded,
                            size: 70, color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Username",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text('@admin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Wrap(
                    spacing: 30,
                    direction: Axis.vertical,
                    children: [
                      const Text(
                        'Negara',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Kebijakan Privasi',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Ketentuan Pemakaian',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Panduan Komunitas Cookpad',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Pertanyaan yang sering Ditanyakan',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Hubungi Kami',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Cek Versi Aplikasi Cookpad',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Mode',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      InkWell(
                          onTap: () async {
                            setState(() {});
                            if (await AuthenticationService(
                                    FirebaseAuth.instance)
                                .signOut()) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const Login();
                              }));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("GAGAL LOGOUT"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
