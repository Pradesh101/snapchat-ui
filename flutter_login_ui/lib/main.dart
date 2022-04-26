import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_login_ui/screens/home_screen.dart';
import 'package:flutter_login_ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  // Disable
  //FirebaseInAppMessaging.instance.setMessagesSuppressed(true);

  // Re-enable
  //FirebaseInAppMessaging.instance.setMessagesSuppressed(false);

  //await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  //print('background message ${message.notification!.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
