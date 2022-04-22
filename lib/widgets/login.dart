import 'package:flutter/material.dart';
import './signup.dart';

class Login extends StatefulWidget {
  static const routeName = '/Login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget InputField(String InputFieldName, IconData iconName) {
    return TextField(
      decoration: InputDecoration(
        labelText: "$InputFieldName",
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 85, 0, 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/photos/dome-and-main-building-of-islamia-college-university-peshawar-picture-id497967720?k=20&m=497967720&s=612x612&w=0&h=L66Z7NQ_fQ5k16qcHQqAuYgXOuBnMsJaZociBZmysZU="),
                ),
              ),
              const Text(
                "Login",
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Text("Forgot Password ?")],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: RaisedButton(
                        child: const Text(
                          "Log In",
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
                        const Text("Don't have account yet? "),
                        GestureDetector(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(SignUp.routeName);
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
