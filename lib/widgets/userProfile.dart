// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './update_renter.dart';

class UserProfile extends StatelessWidget {
  final String renterId;
  final String userName;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  // ignore: use_key_in_widget_constructors
  const UserProfile(this.renterId, this.userName, this.dateOfBirth,
      this.phoneNumber, this.address, this.imageUrl);

  Widget userField(String fieldName, IconData iconName) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      width: double.infinity,
      child: Row(
        children: [
          Icon(iconName),
          const SizedBox(
            width: 10,
          ),
          Text(
            fieldName,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                height: 250,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 165, 218, 212)),
                child: Center(
                  child: Container(
                    // decoration: BoxDecoration(color: Colors.red),
                    margin: const EdgeInsets.only(
                        // top: 20.4,
                        ),
                    width: double.infinity,
                    height: 130,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        userField(userName, Icons.person),
        userField(dateOfBirth, Icons.date_range),
        userField(phoneNumber, Icons.phone),
        userField(address, Icons.home),
        const SizedBox(
          height: 25,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: 60.0,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(
                      left: 130.0, right: 130.0, top: 20, bottom: 20),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text(
                "Update Profile",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(UpdateRenter.routeName, arguments: renterId);
              },
            ),
          ),
        ),
      ],
    );
    //   ),
    // );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
    // ignore: todo
    // TODO: implement getClip
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    // ignore: todo
    // TODO: implement shouldReclip
  }
}
