// ignore: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentnow/widgets/login.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import './login.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  late String email;
  late String password;

  // Widget InputField(String InputFieldName, IconData icon,) {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 65, 0, 10),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/photos/dome-and-main-building-of-islamia-college-university-peshawar-picture-id497967720?k=20&m=497967720&s=612x612&w=0&h=L66Z7NQ_fQ5k16qcHQqAuYgXOuBnMsJaZociBZmysZU="),
                  ),
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30.0),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //Email Field
                      TextField(
                        // here we will get the email entered
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(255, 255, 255, 100),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Password field
                      TextField(
                        obscureText: true,
                        // here we will get the email entered
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(255, 255, 255, 100),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Confirm Password field
                      TextField(
                        obscureText: true,
                        // here we will get the email entered
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(255, 255, 255, 100),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      // Sign Up button
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.only(
                                  left: 150.0,
                                  right: 150.0,
                                  top: 20,
                                  bottom: 20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);

                              if (newUser != null) {
                                Navigator.pushNamed(context, Login.routeName);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
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
                              Navigator.of(context).pushNamed(Login.routeName);
                            },
                          )
                        ],
                      )
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
