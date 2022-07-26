// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/renter.dart';
import './rentItems.dart';
import '../models/http_exception.dart';
import '../Api/firebase_api.dart';

class BecomeRenter extends StatefulWidget {
  static const routeName = "/become-renter";
  const BecomeRenter({Key? key}) : super(key: key);

  @override
  State<BecomeRenter> createState() => _BecomeRenterState();
}

class _BecomeRenterState extends State<BecomeRenter> {
  File? file;
  UploadTask? task;

  final Map<String, String> _renterData = {
    "userName": "",
    'imageUrl': "",
    'dateOfBirth': "",
    'phoneNumber': '',
    'address': '',
  };

  final _formKey = GlobalKey<FormState>();

  InputDecoration _fieldDecoration(String fieldName, IconData iconName) {
    return InputDecoration(
      labelText: fieldName,
      prefixIcon: Icon(
        iconName,
        color: Colors.teal,
      ),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 100),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<Renter>(context, listen: false).addRenter(
          _renterData['userName']!,
          _renterData['imageUrl']!,
          _renterData['dateOfBirth']!,
          _renterData['phoneNumber']!,
          _renterData['address']!);
    } on HttpException catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("somer error"),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error occurs"),
          content: const Text("Please check your internet connection"),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    Navigator.of(context).pushNamed(RentItem.routeName);
  }

  Future<void> selectImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      file = imageTemporary;

      setState(() {
        file = imageTemporary;
      });
    } on PlatformException {
      const snackBar = SnackBar(
        content: Text("Item not Deleted"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget uploadFile(String btnName) {
    return ElevatedButton(
      child: Row(
        children: [
          Text(btnName),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.send),
        ],
      ),
      onPressed: () async {
        if (file != null) {
          final fileName = basename(file!.path);
          final destination = 'files/$fileName';

          task = FirebaseApi.uploadFile(destination, file!);
          setState(() {});
          if (task == null) {
            return;
          }
          final snapshot = await task!.whenComplete(() {});
          final urlDownload = await snapshot.ref.getDownloadURL();

          _renterData['imageUrl'] = urlDownload;
          _submit();

          return;
        }
        return;
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.only(left: 120.0, right: 100.0, top: 20, bottom: 20),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Text(
              "Please wait...$percentage%",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 55.0, 0, 10.0),
                  child: Text(
                    "Become Renter",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 60,
                                child: ClipOval(
                                  child: SizedBox(
                                      width: 180,
                                      height: 180.0,
                                      child: file != null
                                          ? Image.file(
                                              file!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(Icons.camera_alt)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: _fieldDecoration("User Name", Icons.person),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['userName'] = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: _fieldDecoration(
                            "Date Of Birth", Icons.calendar_today_rounded),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['dateOfBirth'] = value!;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration:
                            _fieldDecoration("Phone Number", Icons.phone),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['phoneNumber'] = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: _fieldDecoration("Address", Icons.house),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['address'] = value!;
                        },
                      ),
                      task != null ? buildUploadStatus(task!) : Container(),
                      const SizedBox(
                        height: 55,
                      ),
                      uploadFile("Submit")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  basename(String pat) {
    String actualPath = pat.split("/").last;
    return Text(
      actualPath,
      style: const TextStyle(color: Colors.black),
    );
  }
}
