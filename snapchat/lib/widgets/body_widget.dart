// import 'package:flutter/material.dart';
// import 'package:snapchat/home_screen.dart';
// import 'package:snapchat/models/friend_model.dart';

// class MessageScreen extends StatelessWidget {
//   const MessageScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: const FloatingActionButton(
//         onPressed: null,
//         elevation: 5,
//         child: Icon(Icons.save_as_outlined),
//       ),
//       appBar: const PreferredSize(
//           preferredSize: Size.fromHeight(100.0), child: AppBarWidget()),
//       body: ListView.builder(
//           itemCount: friendList.length,
//           itemBuilder: ((context, index) {
//             return Column(children: <Widget>[
//               ListTile(
//                   leading: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.transparent,
//                       child: Image.asset(friendList[index].imageUrl)),
//                   title: Text(friendList[index].name,
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         friendList[index].status == true
//                             ? Row(children: const [
//                                 Icon(Icons.square_rounded,
//                                     color: Colors.red, size: 15),
//                                 Text(' New Snap ')
//                               ])
//                             : Row(children: const [
//                                 Icon(Icons.check_box_outline_blank_rounded,
//                                     color: Colors.red, size: 15),
//                                 Text(' Received ')
//                               ]),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 5, right: 5),
//                           child: Icon(
//                             Icons.circle,
//                             color: Colors.grey,
//                             size: 5,
//                           ),
//                         ),
//                         Text(friendList[index].time),
//                         if (friendList[index].streak != 0)
//                           Row(children: [
//                             const Padding(
//                                 padding: EdgeInsets.only(left: 5, right: 5),
//                                 child: Icon(Icons.circle,
//                                     color: Colors.grey, size: 5)),
//                             Text(friendList[index].streak.toString(),
//                                 style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold)),
//                             const Icon(Icons.local_fire_department_rounded,
//                                 color: Colors.deepOrange, size: 18)
//                           ])
//                       ]),
//                   trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         SizedBox(height: 15),
//                         Icon(Icons.camera_alt_outlined, size: 25)
//                       ]))
//             ]);
//           })),
//     );
//   }
// }

// // Widget MessageScreen() {
// //   return Scaffold(
// //     floatingActionButton: const FloatingActionButton(
// //       onPressed: null,
// //       elevation: 5,
// //       child: Icon(Icons.save_as_outlined),
// //     ),
// //     appBar: const PreferredSize(
// //         preferredSize: Size.fromHeight(100.0), child: AppBarWidget()),
// //     body: ListView.builder(
// //         itemCount: friendList.length,
// //         itemBuilder: ((context, index) {
// //           return Column(children: <Widget>[
// //             ListTile(
// //                 leading: CircleAvatar(
// //                     radius: 25,
// //                     backgroundColor: Colors.transparent,
// //                     child: Image.asset(friendList[index].imageUrl)),
// //                 title: Text(friendList[index].name,
// //                     style: const TextStyle(fontWeight: FontWeight.bold)),
// //                 subtitle:
// //                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
// //                   friendList[index].status == true
// //                       ? Row(children: const [
// //                           Icon(Icons.square_rounded,
// //                               color: Colors.red, size: 15),
// //                           Text(' New Snap ')
// //                         ])
// //                       : Row(children: const [
// //                           Icon(Icons.check_box_outline_blank_rounded,
// //                               color: Colors.red, size: 15),
// //                           Text(' Received ')
// //                         ]),
// //                   const Padding(
// //                     padding: EdgeInsets.only(left: 5, right: 5),
// //                     child: Icon(
// //                       Icons.circle,
// //                       color: Colors.grey,
// //                       size: 5,
// //                     ),
// //                   ),
// //                   Text(friendList[index].time),
// //                   if (friendList[index].streak != 0)
// //                     Row(children: [
// //                       const Padding(
// //                           padding: EdgeInsets.only(left: 5, right: 5),
// //                           child:
// //                               Icon(Icons.circle, color: Colors.grey, size: 5)),
// //                       Text(friendList[index].streak.toString(),
// //                           style: const TextStyle(
// //                               color: Colors.black,
// //                               fontWeight: FontWeight.bold)),
// //                       const Icon(Icons.local_fire_department_rounded,
// //                           color: Colors.deepOrange, size: 18)
// //                     ])
// //                 ]),
// //                 trailing: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: const [
// //                       SizedBox(height: 15),
// //                       Icon(Icons.camera_alt_outlined, size: 25)
// //                     ]))
// //           ]);
// //         })),
// //   );
// // }

// List<Friend> friendList = [
//   Friend(
//       imageUrl: 'assets/images/user2.png',
//       name: 'Santosh',
//       status: true,
//       time: 'just now',
//       streak: 99),
//   Friend(
//       imageUrl: 'assets/images/user1.png',
//       name: 'Sohil',
//       status: true,
//       time: '30m',
//       streak: 101),
//   Friend(
//       imageUrl: 'assets/images/user4.png',
//       name: 'Sandesh Raj Rijal',
//       status: true,
//       time: '1h',
//       streak: 77),
//   Friend(
//       imageUrl: 'assets/images/user5.png',
//       name: 'Suraj Shrestha',
//       status: true,
//       time: '2h',
//       streak: 76),
//   Friend(
//       imageUrl: 'assets/images/user10.png',
//       name: 'Riya Maharjan',
//       status: true,
//       time: '2h',
//       streak: 55),
//   Friend(
//       imageUrl: 'assets/images/user5.png',
//       name: 'Roma',
//       status: false,
//       time: '3h',
//       streak: 44),
//   Friend(
//       imageUrl: 'assets/images/user3.png',
//       name: 'Aarya DC',
//       status: false,
//       time: '18h',
//       streak: 72),
//   Friend(
//       imageUrl: 'assets/images/user4.png',
//       name: 'Birju',
//       status: false,
//       time: '19h',
//       streak: 111),
//   Friend(
//       imageUrl: 'assets/images/user10.png',
//       name: 'Bob',
//       status: false,
//       time: '5d',
//       streak: 0),
//   Friend(
//       imageUrl: 'assets/images/user4.png',
//       name: 'Hada',
//       status: false,
//       time: '5d',
//       streak: 0),
// ];
