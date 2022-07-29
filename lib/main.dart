import 'package:cookpad_flutter/firebase_options.dart';
import 'package:cookpad_flutter/pages/home_view.dart';
import 'package:cookpad_flutter/pages/login_view.dart';
import 'package:cookpad_flutter/services/notification_handler.dart';
import 'package:cookpad_flutter/services/recipe_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', //title
    description: "This channel is used for important notifications.",
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = 'Cookpad';
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification!.title);
        var _routeName = message.data['route'];
        Navigator.of(context).pushNamed(_routeName);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
      if (message != null) {
        print(message.notification!.title);
        var _routeName = message.data['route'];
        Navigator.of(context).pushNamed(_routeName);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
        var _routeName = message.data['route'];
        Navigator.of(context).pushNamed(_routeName);
      }
    });

    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        title: title,
        home: initialPages(),
      ));

  Widget initialPages() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const Home();
    } else {
      return const Login();
    }
  }
}
