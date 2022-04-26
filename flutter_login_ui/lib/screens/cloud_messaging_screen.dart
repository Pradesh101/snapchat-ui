import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class CloudMessagingScreen extends StatefulWidget {
  const CloudMessagingScreen({Key? key}) : super(key: key);

  @override
  _CloudMessagingScreenState createState() => _CloudMessagingScreenState();
}

class _CloudMessagingScreenState extends State<CloudMessagingScreen> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      //print(value);
    });
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text("Notification"),
    //           content: Text(event.notification!.body!),
    //           actions: [
    //             TextButton(
    //               child: const Text("Ok"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //             )
    //           ],
    //         );
    //       });
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // print("message recieved");
      // print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CMA'),
      ),
      body: const Center(
        child: Text('Hello Cloud messaging app'),
      ),
    );
  }
}
