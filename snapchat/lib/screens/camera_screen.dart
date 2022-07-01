import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snapchat/main.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  late CameraController controller;
  File? capturedImage;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CameraPreview(controller,
            child: Column(children: [
              SafeArea(
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.black.withOpacity(0.3),
                                child: Image.asset("assets/images/user1.png")),
                            const SizedBox(width: 10),
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.black.withOpacity(0.3),
                                child: const IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: null)),
                            const Spacer(),
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.black.withOpacity(0.3),
                                child: const IconButton(
                                    icon: Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                    ),
                                    onPressed: null)),
                            const SizedBox(width: 10),
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(children: const [
                                  Icon(Icons.flip_camera_android,
                                      size: 30, color: Colors.white),
                                  SizedBox(height: 15),
                                  Icon(Icons.flash_on,
                                      size: 30, color: Colors.white),
                                  SizedBox(height: 15),
                                  Icon(Icons.music_note,
                                      size: 30, color: Colors.white)
                                ]))
                          ]))),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black.withOpacity(0.3),
                    child: const IconButton(
                        icon: Icon(
                          Icons.photo_library_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: null)),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    XFile? file = await controller.takePicture();
                    // ignore: unnecessary_null_comparison
                    if (file != null) {
                      setState(() {
                        capturedImage = File(file.path);
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return Scaffold(
                            body: SizedBox(
                                height: double.infinity,
                                child: Image.file(capturedImage!,
                                    fit: BoxFit.fill)));
                      }));
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(100)),
                      child: CircleAvatar(
                          radius: 45,
                          backgroundColor:
                              Colors.transparent.withOpacity(0.0))),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black.withOpacity(0.3),
                    child: const IconButton(
                        icon: Icon(
                          Icons.mood,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: null)),
              ]),
              const SizedBox(height: 20)
            ])));
  }
}
