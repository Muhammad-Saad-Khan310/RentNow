import 'package:flutter/material.dart';

class BecomeRenter extends StatelessWidget {
  static const routeName = "/become-renter";
  const BecomeRenter({Key? key}) : super(key: key);

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
                padding: EdgeInsets.fromLTRB(0.0, 85.0, 0, 20.0),
                child: Text(
                  "Become A Renter",
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
                    InputField("User Name", Icons.person),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Image Url", Icons.image),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Date of Birth", Icons.calendar_today_rounded),
                    const SizedBox(height: 15),
                    InputField("Phone Number", Icons.phone),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField("Address", Icons.house),
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
