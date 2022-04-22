// ignore: file_names
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  static const routeName = "/add-product";
  const AddProduct({Key? key}) : super(key: key);

  Widget InputField(String InputFieldName, IconData iconName) {
    return TextField(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0, 10.0),
                child: Text(
                  "Add Product",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    InputField("Product Title", Icons.add_box),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Image Url", Icons.image),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Price", Icons.money),
                    const SizedBox(height: 15),
                    InputField("Phone No", Icons.phone),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Address", Icons.home),
                    const SizedBox(
                      height: 55,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: RaisedButton(
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
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
    );
  }
}
