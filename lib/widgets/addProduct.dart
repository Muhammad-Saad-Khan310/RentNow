// ignore: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/widgets/rentItems.dart';

import '../providers/item.dart';
import '../providers/items.dart';
import '../screens/categories_items_screen.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "/add-product";
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _form = GlobalKey<FormState>();
  String selectedValue = "Vechiles";
  var _addItem = ProductItem(
      id: "",
      title: "",
      description: "",
      phoneNumber: "",
      imageUrl: "",
      price: "",
      address: "",
      categoryId: "",
      categoryTitle: "Car");

  var _initValues = {
    'title': '',
    'description': '',
    'phoneNumber': '',
    'imageUrl': '',
    'price': '',
    'address': '',
    'categoryTitle': ''
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
        _initValues = {
          'title': _addItem.title,
          'description': _addItem.description,
          'phoneNumber': _addItem.phoneNumber,
          'imageUrl': _addItem.imageUrl,
          'price': _addItem.price,
          'address': _addItem.address,
          'categoryTitle': _addItem.categoryTitle
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

  Widget InputFieldDescription(
      String InputFieldName, IconData iconName, String preValue) {
    return TextFormField(
      initialValue: preValue,
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
            id: _addItem.id,
            title: _addItem.title,
            description: value!,
            phoneNumber: _addItem.phoneNumber,
            imageUrl: _addItem.imageUrl,
            price: _addItem.price,
            address: _addItem.address,
            categoryId: _addItem.categoryId,
            categoryTitle: selectedValue);
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
              FlatButton(
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
    // print(_addItem.title);
    // print(_addItem.id);
    // print(_addItem.imageUrl);
    // print(_addItem.price);
    // print(_addItem.description);
    // print(_addItem.phoneNumber);
    // print(_addItem.address);
    // print(_addItem.categoyTitle);
  }

  List<String> items = ["Vechiles", "Clothes", "Utensils", "Appliances"];

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
                Text(
                  "Please Wait ...",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
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
                          "Add Product",
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
                              // decoration: BoxDecoration(color: Colors.lightBlue),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Select Category"),
                                  DropdownButton<String>(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    value: selectedValue,
                                    items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              initialValue: _initValues["title"],
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
                                    categoryTitle: selectedValue);
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
                            const SizedBox(
                              height: 15,
                            ),
                            // InputField("Image Url", Icons.image, TextInputType.url),
                            TextFormField(
                              initialValue: _initValues["imageUrl"],
                              decoration: _Decoration("Image Url", Icons.image),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.url,
                              onSaved: (value) {
                                _addItem = ProductItem(
                                    id: _addItem.id,
                                    title: _addItem.title,
                                    description: _addItem.description,
                                    phoneNumber: _addItem.phoneNumber,
                                    imageUrl: value!,
                                    price: _addItem.price,
                                    address: _addItem.address,
                                    categoryId: _addItem.categoryId,
                                    categoryTitle: selectedValue);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // InputField("Price", Icons.money, TextInputType.number),
                            TextFormField(
                              initialValue: _initValues["price"],
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
                                    categoryTitle: selectedValue);
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
                              initialValue: _initValues["phoneNumber"],
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
                                    categoryTitle: selectedValue);
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
                              initialValue: _initValues["address"],
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
                                    categoryTitle: selectedValue);
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
                            InputFieldDescription("Descrition",
                                Icons.description, _initValues["description"]!),
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
