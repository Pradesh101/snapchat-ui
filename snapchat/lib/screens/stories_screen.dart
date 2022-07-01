import 'package:flutter/material.dart';
import 'package:snapchat/models/story_model.dart';
import 'package:snapchat/screens/messages_screen.dart';
// import 'package:snapchat/screens/messages_screen.dart';

// ignore: must_be_immutable
class StoryScreen extends StatelessWidget {
  const StoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: Image.asset("assets/images/user1.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey.shade300,
                      child: const IconButton(
                        icon: Icon(Icons.search),
                        onPressed: null,
                      )),
                  const Spacer(),
                  const Text("Stories",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const Spacer(),
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey.shade300,
                      child: const IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: null,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey.shade300,
                      child: const IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                        ),
                        onPressed: null,
                      )),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const SizedBox(height: 15),
              const Text('Stories',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: friendList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 33,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 32,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                  child:
                                      Image.asset(friendList[index].imageUrl),
                                ),
                              ),
                            ));
                      })),
              const Text('Discovers',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: storyList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(storyList[index].imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(8.0)),
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
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ]));
  }
}

final List<Story> storyList = [
  Story(imageUrl: 'assets/images/model2.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model4.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model5.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model3.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model5.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model3.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model2.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model4.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model2.jpg', description: 'Hi Beautiful'),
  Story(imageUrl: 'assets/images/model3.jpg', description: 'Hi Beautiful'),
];
