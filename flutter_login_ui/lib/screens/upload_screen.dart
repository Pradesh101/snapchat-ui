import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/home_screen.dart';
import 'package:flutter_login_ui/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  File? _imageFile;
  bool _loading = false;

  ImagePicker imagePicker = ImagePicker();

  Future<void> _chooseImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    //PickedFile pickedFile = (await imagePicker.pickImage(source: ImageSource.gallery,)) as PickedFile;

    setState(() {
      _imageFile = File(image!.path);
    });
  }

  void _validate() {
    if (_imageFile == null && _descriptionEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please add image and enter description')));
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please add image')));
    } else if (_descriptionEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter description')));
    } else {
      setState(() {
        _loading = true;
      });

      _uploadImage();
    }
  }

  void _uploadImage() {
    //create a unique file name for image
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("Image").child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(_imageFile!);

    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        //save the info to firestore
        _saveData(imageUrl);
      });
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  void _saveData(String imageUrl) {
    var dateFormat = DateFormat("MMM d, yyyy");
    var timeFormat = DateFormat("EEEE, hh:mm a");

    String date = dateFormat.format(DateTime.now()).toString();
    String time = timeFormat.format(DateTime.now()).toString();

    FirebaseFirestore.instance.collection("posts").add({
      "imageUrl": imageUrl,
      "description": _descriptionEditingController.text,
      "date": date,
      "time": time,
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Post added successfully',
            style: TextStyle(color: Colors.green),
          )));
      _goHomeScreen();
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  void _goHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          title: const Text('Upload Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              _imageFile == null
                  ? Container(
                      width: double.infinity,
                      height: 250.0,
                      color: Colors.grey,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _chooseImage();
                          },
                          child: const Text("Choose image"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              textStyle: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _chooseImage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 14.0,
              ),
              TextField(
                controller: _descriptionEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(
                height: 28.0,
              ),
              _loading
                  ? circularProgressBar()
                  : GestureDetector(
                      onTap: () {
                        _validate();
                      },
                      child: Container(
                        color: Colors.blue,
                        width: double.infinity,
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Add new post",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
