// ignore: file_names
import 'package:flutter/material.dart';

import './login.dart';

class SignUp extends StatelessWidget {
  static const routeName = "/SignUp";
  const SignUp({Key? key}) : super(key: key);

  Widget InputField(String InputFieldName, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: "$InputFieldName",
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),

        filled: true,
        // fillColor: const Color.fromRGBO(249, 251, 252, 1),
        fillColor: const Color.fromRGBO(255, 255, 255, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    InputField("Email", Icons.email),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Password", Icons.lock),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Confirm Password", Icons.lock),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: RaisedButton(
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                            style: TextStyle(color: Colors.blue, fontSize: 16),
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
    );
  }
}
