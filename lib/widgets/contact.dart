import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactUs extends StatelessWidget {
  static const routeName = "/contact-us";
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.2),
          child: Column(
            children: [
              Text(
                "Contact Rent Now Team at",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("rentNow@gmail.com")
            ],
          )),
    );
  }
}
