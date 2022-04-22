import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 60.4,
            ),
            width: 70,
            height: 70,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd5Xj7YdVbUD-j4EdgYYPWxV0Ma6awO4g-jQ&usqp=CAU"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Center(
              child: Text(
                "M Saad Khan",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Hayatabad Phase 7 E5 Sector"),
          )
        ],
      ),
    );
  }
}
