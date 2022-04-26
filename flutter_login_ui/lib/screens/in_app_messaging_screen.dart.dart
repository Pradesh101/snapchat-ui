//import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class InappmessageScreen extends StatefulWidget {
  const InappmessageScreen({Key? key}) : super(key: key);

  @override
  _InappmessageScreenState createState() => _InappmessageScreenState();
}

class _InappmessageScreenState extends State<InappmessageScreen> {
  void _instanceId() async {
    // var token = await FirebaseMessaging.instance.getToken();
    //print("Print Instance Token ID: " + token!);
  }

  @override
  void initState() {
    super.initState();
    _instanceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          // FirebaseInAppMessaging.instance
          //     .triggerEvent("manual trigger")
          //     .then((value) => print('success'))
          //     .catchError((e) => print(e));
        },
        child: const Text('In-app messaging'),
      )),
    );
  }
}
