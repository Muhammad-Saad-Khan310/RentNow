import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/profile_screen.dart';
import '../providers/renter.dart';
import '../models/http_exception.dart';
import '../Api/firebase_api.dart';

class UpdateRenter extends StatefulWidget {
  static const routeName = "/update-renter";
  const UpdateRenter({Key? key}) : super(key: key);

  @override
  State<UpdateRenter> createState() => _UpdateRenterState();
}

class _UpdateRenterState extends State<UpdateRenter> {
  File? file;
  UploadTask? task;
  bool imageSelected = false;

  final _formKey = GlobalKey<FormState>();

  var _updateRenter = RenterClass(
      id: "",
      userName: "",
      dateOfBirth: "",
      phoneNumber: "",
      address: "",
      imageUrl: "");

  var _initValues = {
    'userName': '',
    'dateOfBirth': '',
    'imageUrl': '',
    'phoneNumber': '',
    'address': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final renterId = ModalRoute.of(context)!.settings.arguments as String?;

      _updateRenter =
          Provider.of<Renter>(context, listen: false).findById(renterId!);

      _initValues = {
        'userName': _updateRenter.userName,
        'dateOfBirth': _updateRenter.dateOfBirth,
        'phoneNumber': _updateRenter.phoneNumber,
        'imageUrl': _updateRenter.imageUrl,
        'address': _updateRenter.address,
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Widget InputField(String InputFieldName, IconData iconName) {
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
        borderRadius: BorderRadius.circular(10.0),
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
      await Provider.of<Renter>(context, listen: false)
          .updateRenter(_updateRenter.id, _updateRenter);
    } on HttpException catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("some error"),
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

    Navigator.of(context).pushNamed(ProfileScreen.routeName);
  }

  Future<void> selectImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      file = imageTemporary;

      setState(() {
        imageSelected = true;
        file = imageTemporary;
      });
      // ignore: empty_catches
    } on PlatformException {}
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
            imageSelected = false;

            return;
          }
          final snapshot = await task!.whenComplete(() {});
          final urlDownload = await snapshot.ref.getDownloadURL();
          imageSelected = true;
          _updateRenter = RenterClass(
            id: _updateRenter.id,
            userName: _updateRenter.userName,
            dateOfBirth: _updateRenter.dateOfBirth,
            phoneNumber: _updateRenter.phoneNumber,
            imageUrl: urlDownload,
            address: _updateRenter.address,
          );
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
                    "Update Profile",
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
                                              fit: BoxFit.contain,
                                            )
                                          : Image.network(
                                              _updateRenter.imageUrl,
                                              fit: BoxFit.cover,
                                            )),
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
                        initialValue: _initValues["userName"],
                        decoration: _fieldDecoration("User Name", Icons.person),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _updateRenter = RenterClass(
                            id: _updateRenter.id,
                            userName: value!,
                            dateOfBirth: _updateRenter.dateOfBirth,
                            phoneNumber: _updateRenter.phoneNumber,
                            imageUrl: _updateRenter.imageUrl,
                            address: _updateRenter.address,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _initValues["dateOfBirth"],
                        decoration: _fieldDecoration(
                            "Date Of Birth", Icons.calendar_today_rounded),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _updateRenter = RenterClass(
                            id: _updateRenter.id,
                            userName: _updateRenter.userName,
                            dateOfBirth: value!,
                            phoneNumber: _updateRenter.phoneNumber,
                            imageUrl: _updateRenter.imageUrl,
                            address: _updateRenter.address,
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        initialValue: _initValues["phoneNumber"],
                        decoration:
                            _fieldDecoration("Phone Number", Icons.phone),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _updateRenter = RenterClass(
                            id: _updateRenter.id,
                            userName: _updateRenter.userName,
                            dateOfBirth: _updateRenter.dateOfBirth,
                            phoneNumber: value!,
                            imageUrl: _updateRenter.imageUrl,
                            address: _updateRenter.address,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _initValues["address"],
                        decoration: _fieldDecoration("Address", Icons.house),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _updateRenter = RenterClass(
                            id: _updateRenter.id,
                            userName: _updateRenter.userName,
                            dateOfBirth: _updateRenter.dateOfBirth,
                            phoneNumber: _updateRenter.phoneNumber,
                            imageUrl: _updateRenter.imageUrl,
                            address: value!,
                          );
                        },
                      ),
                      task != null ? buildUploadStatus(task!) : Container(),
                      const SizedBox(
                        height: 55,
                      ),
                      imageSelected
                          ? uploadFile("Update")
                          : ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(
                                        left: 130.0,
                                        right: 130.0,
                                        top: 20,
                                        bottom: 20),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _submit();
                                },
                              ),
                            ),
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
