import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/profile_screen.dart';
import './rentItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentnow/widgets/becomeRenter.dart';
import './signup.dart';
import '../models/http_exception.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../screens/user_products_screen.dart';

class Login extends StatefulWidget {
  static const routeName = '/Login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
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

  // Widget InputField(String InputFieldName, IconData icon,) {
  // ignore: non_constant_identifier_names
  InputDecoration Decoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  @override
  void initState() {
    super.initState();
  }

  // Widget InputField(String InputFieldName, IconData iconName) {
  //   return TextField(
  //     onChanged: (value) {
  //       email = value;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "$InputFieldName",
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
  //   );
  // }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    try {
      var data = Provider.of<Auth>(context, listen: false);
      await data.login(_authData['email']!, _authData['password']!);

      // if (data.isAllowed) {
      Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
      // }
    } on HttpException catch (error) {
      var errorMessage = "Authenticate failed";
      if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Could not find a user with that email.";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      var errorMessage = "Could not authenticate you. Please try again later.";
      _showErrorDialog(errorMessage);
    }
    // if (_authMode == AuthMode.Login) {
    //   // Log user in
    // } else {
    //   // Sign user up
    // }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/app_logo.png'),
                  ),
                ),
                // Positioned(
                //   top: MediaQuery.of(context).size.height * 0.3,
                //   left: MediaQuery.of(context).size.width * 0.4,
                //   child: Text(
                //     "Login",
                //     style:
                //         TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                //   ),
                // ),
                const SizedBox(
                  height: 0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsetsDirectional.only(
                      top: MediaQuery.of(context).size.height * 0.38),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // InputField("Email", Icons.email),
                        TextFormField(
                          // here we will get the email entered

                          decoration: Decoration("Email", Icons.email),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
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
                        // InputField("Password", Icons.lock),

                        TextFormField(
                          keyboardType: TextInputType.name,
                          obscureText: true,
                          decoration: Decoration("Password", Icons.lock),
                          textInputAction: TextInputAction.next,
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Text("Forgot Password ?")],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            :
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: [
                            //       Text(
                            //         "Login",
                            //         style: TextStyle(
                            //             fontSize: 30,
                            //             fontWeight: FontWeight.w700),
                            //       ),
                            //       CircleAvatar(
                            //         radius: 30,
                            //         backgroundColor: Colors.teal,
                            //         child: IconButton(
                            //             onPressed: () {
                            //               _submit();
                            //             },
                            //             icon: Icon(Icons.arrow_forward)),
                            //       )
                            //     ],
                            //   )
                            ButtonTheme(
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
                                    "Log In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _submit();
                                  },

                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(15),
                                  // ),
                                ),
                              ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account yet? "),
                            GestureDetector(
                              child: const Text(
                                "Sign Up",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SignUp.routeName);
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
