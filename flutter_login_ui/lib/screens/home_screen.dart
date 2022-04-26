import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/login_screen.dart';
import 'package:flutter_login_ui/models/posts.dart';
import 'package:flutter_login_ui/screens/update_screen.dart';
import 'package:flutter_login_ui/screens/upload_screen.dart';
import 'package:flutter_login_ui/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Widget _cardUI(Post post) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  post.date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  post.time,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateScreen(id: post.id)));
                    },
                    icon: const Icon(Icons.update_outlined)),
                IconButton(
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.id)
                          .delete();
                    },
                    icon: const Icon(Icons.delete_outline_rounded))
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Image.network(
              post.imageUrl,
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(post.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0, color: Colors.indigo)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadScreen()));
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: (() {
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout Successfully!!!')));
                }).catchError((error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              }),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: const Text('Home Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Empty Data'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: circularProgressBar(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String id = snapshot.data!.docs[index].id;
                  Map<String, dynamic>? postMap = snapshot.data!.docs[index]
                      .data() as Map<String, dynamic>?;
                  Post post = Post(postMap!['imageUrl'], postMap['description'],
                      postMap['date'], postMap['time'], id);
                  return _cardUI(post);
                });
          }
        },
      ),
    );
  }
}
