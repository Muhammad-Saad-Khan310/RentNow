// ignore: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/rentItems.dart';
import '../widgets/login.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
    'confirmPassword': '',
  };
  var _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("An error occured!"),
        content: Text(message),
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

  // ignore: non_constant_identifier_names
  InputDecoration Decoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 100),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authData['password'] != _authData['confirmPassword']) {
      var errorMessage = "Password and Confirm Password not match";
      _showErrorDialog(errorMessage);
    } else {
      try {
        var data = Provider.of<Auth>(context, listen: false);
        await data
            .signup(_authData['email']!, _authData['password']!)
            .then((value) {
          Navigator.of(context).pushReplacementNamed(RentItem.routeName);
        });
      } on HttpException catch (error) {
        var errorMessage = "Authenticate failed";
        if (error.toString().contains("EMAIL_EXISTS")) {
          errorMessage = "This email address is already in use.";
        } else if (error.toString().contains("INVALID_EMAIL")) {
          errorMessage = "This is not a valid email.";
        } else if (error.toString().contains("WEAK_PASSWORD")) {
          errorMessage = "This password is too weak.";
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        var errorMessage =
            "Could not authenticate you. Please try again later.";
        _showErrorDialog(errorMessage);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Signup")),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsetsDirectional.only(
                      top: MediaQuery.of(context).size.height * 0.23),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Email Field
                        TextFormField(
                          decoration: Decoration("Email", Icons.email),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Product title";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value!;
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // Password field
                        TextFormField(
                          decoration: Decoration("Password", Icons.lock),
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // Confirm Password field
                        TextFormField(
                          // here we will get the email entered

                          decoration: Decoration(
                              "Confirm Password", Icons.lock_person_rounded),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Confirm Password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['confirmPassword'] = value!;
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        // Sign Up button
                        _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                height: 60.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.only(
                                          left: 125.0,
                                          right: 125.0,
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
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _submit();
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have account ? "),
                            GestureDetector(
                              child: const Text(
                                "Log in",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Login.routeName);
                              },
                            )
                          ],
                        )
                      ],
                    ),
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
