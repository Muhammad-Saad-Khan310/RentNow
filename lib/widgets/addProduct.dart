// ignore: file_names
import 'package:flutter/material.dart';

import '../providers/item.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "/add-product";
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _form = GlobalKey<FormState>();
  var _addItem = ProductItem(
      id: "",
      title: "",
      description: "",
      phoneNumber: 0,
      imageUrl: "",
      price: 0,
      address: "",
      categoryId: "",
      categoyTitle: "");

  InputDecoration _Decoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.blue,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 100),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)));
  }

  // Widget InputField(
  //     String InputFieldName, IconData iconName, TextInputType keyType) {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: InputFieldName,
  //       prefixIcon: Icon(
  //         iconName,
  //         color: Colors.blue,
  //       ),
  //       filled: true,
  //       fillColor: const Color.fromRGBO(255, 255, 255, 100),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //     ),
  //     textInputAction: TextInputAction.next,
  //     keyboardType: keyType,
  //     onSaved: (value) {
  //       list.add(value);
  //       // _addItem = ProductItem(
  //       //     id: "",
  //       //     title: value!,
  //       //     description: value,
  //       //     imageUrl: value,
  //       //     price: 80.7,
  //       //     address: value,
  //       //     categoryId: value,
  //       //     categoyTitle: value);
  //     },
  //   );
  // }

  Widget InputFieldDescription(String InputFieldName, IconData iconName) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: InputFieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.blue,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 100),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      // textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) {
        _saveForm();
      },
      onSaved: (value) {
        _addItem = ProductItem(
            id: "",
            title: _addItem.title,
            description: value!,
            phoneNumber: _addItem.phoneNumber,
            imageUrl: _addItem.imageUrl,
            price: _addItem.price,
            address: _addItem.address,
            categoryId: _addItem.categoryId,
            categoyTitle: _addItem.categoyTitle);
      },
    );
  }

// ignore: prefer_final_fields

  void _saveForm() {
    _form.currentState!.save();
    print(_addItem.title);
    print(_addItem.imageUrl);
    print(_addItem.price);
    print(_addItem.description);
    print(_addItem.phoneNumber);
    print(_addItem.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Add Product"),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _form,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 10.0),
                  child: Text(
                    "Add Product",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: _Decoration("Product Title", Icons.add_box),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _addItem = ProductItem(
                              id: "",
                              title: value!,
                              description: _addItem.description,
                              phoneNumber: _addItem.phoneNumber,
                              imageUrl: _addItem.imageUrl,
                              price: _addItem.price,
                              address: _addItem.address,
                              categoryId: _addItem.categoryId,
                              categoyTitle: _addItem.categoyTitle);
                        },
                      ),
                      // InputField(
                      //     "Product Title", Icons.add_box, TextInputType.name),
                      const SizedBox(
                        height: 15,
                      ),
                      // InputField("Image Url", Icons.image, TextInputType.url),
                      TextFormField(
                        decoration: _Decoration("Image Url", Icons.image),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.url,
                        onSaved: (value) {
                          _addItem = ProductItem(
                              id: "",
                              title: _addItem.title,
                              description: _addItem.description,
                              phoneNumber: _addItem.phoneNumber,
                              imageUrl: value!,
                              price: _addItem.price,
                              address: _addItem.address,
                              categoryId: _addItem.categoryId,
                              categoyTitle: _addItem.categoyTitle);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // InputField("Price", Icons.money, TextInputType.number),
                      TextFormField(
                        decoration: _Decoration("Price", Icons.money),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _addItem = ProductItem(
                              id: "",
                              title: _addItem.title,
                              description: _addItem.description,
                              phoneNumber: _addItem.phoneNumber,
                              imageUrl: _addItem.imageUrl,
                              price: double.parse(value!),
                              address: _addItem.address,
                              categoryId: _addItem.categoryId,
                              categoyTitle: _addItem.categoyTitle);
                        },
                      ),
                      const SizedBox(height: 15),
                      // InputField("Phone No", Icons.phone, TextInputType.number),
                      TextFormField(
                        decoration: _Decoration("Phone No", Icons.phone),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _addItem = ProductItem(
                              id: "",
                              title: _addItem.title,
                              description: _addItem.description,
                              phoneNumber: int.parse(value!),
                              imageUrl: _addItem.imageUrl,
                              price: _addItem.price,
                              address: _addItem.address,
                              categoryId: _addItem.categoryId,
                              categoyTitle: _addItem.categoyTitle);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // InputField("Address", Icons.home, TextInputType.name),
                      TextFormField(
                        decoration: _Decoration("Address", Icons.home),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _addItem = ProductItem(
                              id: "",
                              title: _addItem.title,
                              description: _addItem.description,
                              phoneNumber: _addItem.phoneNumber,
                              imageUrl: _addItem.imageUrl,
                              price: _addItem.price,
                              address: value!,
                              categoryId: _addItem.categoryId,
                              categoyTitle: _addItem.categoyTitle);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputFieldDescription("Descrition", Icons.description),
                      const SizedBox(
                        height: 45,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 60.0,
                        child: RaisedButton(
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _saveForm();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
}
