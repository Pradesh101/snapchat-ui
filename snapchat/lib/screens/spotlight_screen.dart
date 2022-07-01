import 'package:flutter/material.dart';
import 'package:snapchat/screens/stories_screen.dart';

class SpotlightScreen extends StatelessWidget {
  const SpotlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            height: 60,
            //margin: const EdgeInsets.only(bottom: 10),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black,
                  child: Image.asset("assets/images/user1.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    )),
                const SizedBox(
                  width: 60,
                ),
                const Text("Spotlight",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: storyList.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: MediaQuery.of(context).size.height - 168,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(storyList[index].imageUrl),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        width: 180,
                        child: Text(
                          storyList[index].description,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ],
              ),
            );
          })),
    );
  }
}
