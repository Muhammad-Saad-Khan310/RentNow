import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/renter.dart';
import './rentItems.dart';
import '../models/http_exception.dart';

class BecomeRenter extends StatefulWidget {
  static const routeName = "/become-renter";
  BecomeRenter({Key? key}) : super(key: key);

  @override
  State<BecomeRenter> createState() => _BecomeRenterState();
}

class _BecomeRenterState extends State<BecomeRenter> {
  Map<String, String> _renterData = {
    "userName": "",
    'imageUrl': "",
    'dateOfBirth': "",
    'phoneNumber': '',
    'address': '',
  };

  final _formKey = GlobalKey<FormState>();

  // Widget InputField(String InputFieldName, IconData iconName) {
  InputDecoration _fieldDecoration(String fieldName, IconData iconName) {
    return InputDecoration(
      labelText: fieldName,
      prefixIcon: Icon(
        iconName,
        // color: Colors.blue,
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
                title: Text("somer error"),
                content: Text(error.toString()),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              ));
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error occurs"),
          content: const Text("Please check your internet connection"),
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

    Navigator.of(context).pushNamed(RentItem.routeName);
  }

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
                  padding: EdgeInsets.fromLTRB(0.0, 85.0, 0, 20.0),
                  child: Text(
                    "Become Renter",
                    style: TextStyle(fontSize: 25.0),
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
                        decoration: _fieldDecoration("Image Url", Icons.image),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['imageUrl'] = value!;
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
                      // InputField("Phone Number", Icons.phone),
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
                      // InputField("Address", Icons.house),
                      TextFormField(
                        decoration: _fieldDecoration("Address", Icons.house),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          _renterData['address'] = value!;
                        },
                      ),
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
                          onPressed: () {
                            _submit();
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
