import 'package:flutter/material.dart';
import 'package:snapchat/screens/camera_screen.dart';
import 'package:snapchat/screens/location_screen.dart';
import 'package:snapchat/screens/messages_screen.dart';
import 'package:snapchat/screens/spotlight_screen.dart';
import 'package:snapchat/screens/stories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedtIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedtIndex = index;
      controller.jumpToPage(index);
    });
  }

  PageController controller = PageController(initialPage: 2);

  final List<Widget> _screens = [
    const LocationScreen(),
    const MessageScreen(),
    const CaptureScreen(),
    const StoryScreen(),
    const SpotlightScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBarWidget(),
      body: PageView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        onPageChanged: (ind) {
          setState(() {
            _selectedtIndex = ind;
          });
        },
        controller: controller,
        children: _screens,
      ),
    );
  }

  BottomNavigationBar bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedtIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.location_on_outlined,
                  color: _selectedtIndex == 0 ? Colors.green : Colors.white)),
          BottomNavigationBarItem(
              label: '',
              icon: Transform.scale(
                  scaleX: -1,
                  child: Icon(Icons.messenger_outline_outlined,
                      color:
                          _selectedtIndex == 1 ? Colors.blue : Colors.white))),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.camera_alt_outlined,
                  color: _selectedtIndex == 2 ? Colors.yellow : Colors.white)),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.group,
                  color: _selectedtIndex == 3 ? Colors.purple : Colors.white)),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.play_arrow,
                  color: _selectedtIndex == 4 ? Colors.red : Colors.white))
        ]);
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: Image.asset("assets/images/user1.png")),
              const SizedBox(width: 10),
              CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: const IconButton(
                      icon: Icon(Icons.search), onPressed: null)),
              const Spacer(),
              const Text("Chat",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Spacer(),
              CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: const IconButton(
                      icon: Icon(Icons.person_add), onPressed: null)),
              const SizedBox(width: 10),
              CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: const IconButton(
                      icon: Icon(Icons.more_horiz), onPressed: null))
            ])));
  }
}
