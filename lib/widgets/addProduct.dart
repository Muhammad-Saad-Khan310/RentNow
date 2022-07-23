// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/retry.dart';

import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentnow/widgets/rentItems.dart';

import '../providers/item.dart';
import '../providers/items.dart';
import '../providers/renter.dart';
import '../Api/firebase_api.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "/add-product";
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _form = GlobalKey<FormState>();
  String selectedValue = "Vehicles";
  File? file;
  UploadTask? task;
  bool imagePresent = false;
  String? previousUrl;
  var _addItem = ProductItem(
      id: "",
      title: "",
      description: "",
      phoneNumber: "",
      imageUrl: "",
      price: "",
      address: "",
      categoryId: "",
      categoryTitle: "Car",
      available: true,
      validItem: false,
      userEmail: "");

  var _initValues = {
    'title': '',
    'description': '',
    'phoneNumber': '',
    'imageUrl': '',
    'price': '',
    'address': '',
    'categoryTitle': '',
    'available': bool,
    'validItem': bool,
    'userEmail': "",
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;

      if (productId != null) {
        _addItem =
            Provider.of<Items>(context, listen: false).findById(productId);
        selectedValue = _addItem.categoryTitle;
        _available = _addItem.available;

        // print(_addItem.imageUrl.);
        file = File(_addItem.imageUrl);
        previousUrl = _addItem.imageUrl;
        _initValues = {
          'title': _addItem.title,
          'description': _addItem.description,
          'phoneNumber': _addItem.phoneNumber,
          'imageUrl': _addItem.imageUrl,
          'price': _addItem.price,
          'address': _addItem.address,
          'categoryTitle': _addItem.categoryTitle,
          'available': _addItem.available,
          'validItem': _addItem.validItem,
          'userEmail': _addItem.userEmail,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  InputDecoration _Decoration(String fieldName, IconData iconName) {
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

  Widget InputFieldDescription(
      String InputFieldName, IconData iconName, String preValue) {
    return TextFormField(
      initialValue: preValue,
      decoration: InputDecoration(
        labelText: InputFieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 100),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onFieldSubmitted: (_) {
        _saveForm();
      },
      onSaved: (value) {
        _addItem = ProductItem(
            id: _addItem.id,
            title: _addItem.title,
            description: value!,
            phoneNumber: _addItem.phoneNumber,
            imageUrl: _addItem.imageUrl,
            price: _addItem.price,
            address: _addItem.address,
            categoryId: _addItem.categoryId,
            categoryTitle: selectedValue,
            available: _available,
            validItem: _addItem.validItem,
            userEmail: _addItem.userEmail);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter Description";
        }
        return null;
      },
    );
  }

  Future<void> _saveForm() async {
    // This below line return boolean value
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_addItem.id != "") {
      await Provider.of<Items>(context, listen: false)
          .updateItem(_addItem.id, _addItem);
    } else {
      try {
        await Provider.of<Items>(context, listen: false).addItem(_addItem);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error occurs"),
            content: const Text("Something went wrong"),
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
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pushNamed(RentItem.routeName);
      //   // Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();

    Navigator.of(context).pushNamed(RentItem.routeName);
  }

  // Widget selectFile(String btnName) {
  //   return ElevatedButton(
  //     child: file != null
  //         ? basename(file!.path)
  //         : Text(
  //             "⍓︎ " + btnName,
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //     onPressed: () async {
  //       imagePresent = true;
  //       final result =
  //           await FilePicker.platform.pickFiles(allowMultiple: false);
  //       if (result == null) {
  //         imagePresent = false;
  //         return;
  //       }

  //       final path = result.files.single.path!;
  //       setState(() => file = File(path));
  //     },
  //     style: ElevatedButton.styleFrom(
  //         primary: Colors.white,
  //         minimumSize: const Size.fromHeight(60),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0))),
  //   );
  // }
  Widget selectFile(String btnName) {
    return ElevatedButton(
      child: file != null
          ? basename(file!.path)
          : Text(
              "⍓︎ " + btnName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
      onPressed: () async {
        try {
          imagePresent = true;
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image == null) return;
          final imageTemporary = File(image.path);
          file = imageTemporary;
          setState(() {
            file = imageTemporary;
          });
        } on PlatformException catch (e) {
          print("failed to pick image");
        }
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: const Size.fromHeight(60),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(10.0))),
    );
  }

  Widget uploadFile(String btnName) {
    return ElevatedButton(
      // style
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
        final snackBar = SnackBar(
          content: Text(
              "Your Item is sending to Admin Portal for verification Process"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (imagePresent) {
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
            _addItem = ProductItem(
                id: _addItem.id,
                title: _addItem.title,
                description: _addItem.description,
                phoneNumber: _addItem.phoneNumber,
                imageUrl: urlDownload,
                price: _addItem.price,
                address: _addItem.address,
                categoryId: _addItem.categoryId,
                categoryTitle: selectedValue,
                available: _available,
                validItem: _addItem.validItem,
                userEmail: _addItem.userEmail);

            _saveForm();

            return;
          }
          return;
        } else {
          _addItem = ProductItem(
              id: _addItem.id,
              title: _addItem.title,
              description: _addItem.description,
              phoneNumber: _addItem.phoneNumber,
              imageUrl: previousUrl!,
              price: _addItem.price,
              address: _addItem.address,
              categoryId: _addItem.categoryId,
              categoryTitle: selectedValue,
              available: _available,
              validItem: _addItem.validItem,
              userEmail: _addItem.userEmail);

          _saveForm();
        }
      },

      // style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
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

  //   Future<void> uploadFile() async {
  //       if (file != null) {
  //         final fileName = basename(file!.path);
  //         final destination = 'files/$fileName';

  //         task = FirebaseApi.uploadFile(destination, file!);
  //         if (task == null) {
  //           return;
  //         }
  //         final snapshot = await task!.whenComplete(() {});
  //         final urlDownload = await snapshot.ref.getDownloadURL();
  //         _addItem = ProductItem(
  //                                   id: _addItem.id,
  //                                   title: _addItem.title,
  //                                   description: _addItem.description,
  //                                   phoneNumber: _addItem.phoneNumber,
  //                                   imageUrl: urlDownload,
  //                                   price: _addItem.price,
  //                                   address: _addItem.address,
  //                                   categoryId: _addItem.categoryId,
  //                                   categoryTitle: selectedValue,
  //                                   available: _available);
  //         print(urlDownload);
  //         _saveForm();

  //         return;
  //       }
  //       return;
  //     }
  // }
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

  List<String> items = ["Vehicles", "Clothes", "Utensils", "Appliances"];
  var _available = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Add Product"),
      // ),
      body: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    "Please Wait ...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          // const Center(
          //     child: CircularProgressIndicator(),
          //   )
          : SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 10.0),
                        child: Text(
                          "Add Item",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              // decoration:
                              //     BoxDecoration(color: Colors.lightBlue),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Select Category"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButton<String>(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                          });
                                        },
                                        value: selectedValue,
                                        items:
                                            items.map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                      Row(
                                        // height: 50,
                                        // width: 32,
                                        children: [
                                          const Text("Available"),
                                          Switch(
                                            activeColor: Colors.blue,
                                            value: _available,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _available = value;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            selectFile("Select Image"),

                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              initialValue: _initValues["title"] as String,
                              decoration:
                                  _Decoration("Product Title", Icons.add_box),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onSaved: (value) {
                                _addItem = ProductItem(
                                    id: _addItem.id,
                                    title: value!,
                                    description: _addItem.description,
                                    phoneNumber: _addItem.phoneNumber,
                                    imageUrl: _addItem.imageUrl,
                                    price: _addItem.price,
                                    address: _addItem.address,
                                    categoryId: _addItem.categoryId,
                                    categoryTitle: selectedValue,
                                    available: _available,
                                    validItem: _addItem.validItem,
                                    userEmail: _addItem.userEmail);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter Product title";
                                }
                                return null;
                              },
                            ),
                            // InputField(
                            //     "Product Title", Icons.add_box, TextInputType.name),

                            // InputField("Image Url", Icons.image, TextInputType.url),

                            // TextFormField(
                            //   initialValue: _initValues["imageUrl"] as String,
                            //   decoration: _Decoration("Image Url", Icons.image),
                            //   textInputAction: TextInputAction.next,
                            //   keyboardType: TextInputType.url,
                            //   onSaved: (value) {
                            //     _addItem = ProductItem(
                            //         id: _addItem.id,
                            //         title: _addItem.title,
                            //         description: _addItem.description,
                            //         phoneNumber: _addItem.phoneNumber,
                            //         imageUrl: value!,
                            //         price: _addItem.price,
                            //         address: _addItem.address,
                            //         categoryId: _addItem.categoryId,
                            //         categoryTitle: selectedValue,
                            //         available: _available);
                            //   },
                            // ),
                            const SizedBox(
                              height: 15,
                            ),

                            TextFormField(
                              initialValue: _initValues["price"] as String,
                              decoration: _Decoration("Price", Icons.money),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                _addItem = ProductItem(
                                    id: _addItem.id,
                                    title: _addItem.title,
                                    description: _addItem.description,
                                    phoneNumber: _addItem.phoneNumber,
                                    imageUrl: _addItem.imageUrl,
                                    price: value!,
                                    address: _addItem.address,
                                    categoryId: _addItem.categoryId,
                                    categoryTitle: selectedValue,
                                    available: _available,
                                    validItem: _addItem.validItem,
                                    userEmail: _addItem.userEmail);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter rent Price.";
                                }
                                if (double.tryParse(value) == null) {
                                  return "Please enter a valid Price number.";
                                }
                                if (double.tryParse(value)! <= 10) {
                                  return "Please enter a number greater than 10.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            // InputField("Phone No", Icons.phone, TextInputType.number),
                            TextFormField(
                              initialValue:
                                  _initValues["phoneNumber"] as String,
                              decoration: _Decoration("Phone No", Icons.phone),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                _addItem = ProductItem(
                                    id: _addItem.id,
                                    title: _addItem.title,
                                    description: _addItem.description,
                                    phoneNumber: value!,
                                    imageUrl: _addItem.imageUrl,
                                    price: _addItem.price,
                                    address: _addItem.address,
                                    categoryId: _addItem.categoryId,
                                    categoryTitle: selectedValue,
                                    available: _available,
                                    validItem: _addItem.validItem,
                                    userEmail: _addItem.userEmail);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter contact number.";
                                }
                                if (int.tryParse(value) == null) {
                                  return "Please enter a valid number.";
                                }
                                // if (value.length != 11) {
                                //   return "Please enter a valid number.";
                                // }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // InputField("Address", Icons.home, TextInputType.name),
                            TextFormField(
                              initialValue: _initValues["address"] as String,
                              decoration: _Decoration("Address", Icons.home),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onSaved: (value) {
                                _addItem = ProductItem(
                                    id: _addItem.id,
                                    title: _addItem.title,
                                    description: _addItem.description,
                                    phoneNumber: _addItem.phoneNumber,
                                    imageUrl: _addItem.imageUrl,
                                    price: _addItem.price,
                                    address: value!,
                                    categoryId: _addItem.categoryId,
                                    categoryTitle: selectedValue,
                                    available: _available,
                                    validItem: _addItem.validItem,
                                    userEmail: _addItem.userEmail);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter item address.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputFieldDescription(
                                "Descrition",
                                Icons.description,
                                _initValues["description"] as String),
                            task != null
                                ? buildUploadStatus(task!)
                                : Container(),
                            const SizedBox(
                              height: 45,
                            ),
                            // ButtonTheme(
                            //   minWidth: MediaQuery.of(context).size.width,
                            //   height: 60.0,
                            //   child: RaisedButton(
                            //     child: const Text(
                            //       "Submit",
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //     onPressed: () {
                            //       _saveForm();
                            //     },
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //     ),
                            //   ),
                            // ),

                            uploadFile("Submit"),
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
