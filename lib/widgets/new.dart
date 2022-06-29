import 'package:flutter/material.dart';
import './update_renter.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final String userName;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  ProfilePage(this.userId, this.userName, this.dateOfBirth, this.phoneNumber,
      this.address, this.imageUrl);

  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Widget userField(String fieldName, IconData iconName) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      width: double.infinity,
      child: Row(
        children: [
          Icon(iconName),
          SizedBox(
            width: 10,
          ),
          Text(
            fieldName,
            style: TextStyle(fontSize: 20),
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

  Widget userNameField(String fieldName) {
    return Container(
      margin: const EdgeInsets.only(top: 55, left: 20, right: 20),
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 10,
          ),
          Text(
            fieldName,
            style: TextStyle(fontSize: 20),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // textfield(
                      //   hintText: 'Username',
                      // ),
                      userNameField(userName),
                      userField(dateOfBirth, Icons.date_range),
                      userField(phoneNumber, Icons.phone),
                      userField(address, Icons.home),

                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print("hello");
                          },
                          child: Text("hello")),

                      SizedBox(height: 55)
                    ],
                  ),
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl
                        // "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"
                        ),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 270, left: 184),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.black54,
          //     child: Container(),
          //     // child: IconButton(
          //     //   icon: Icon(
          //     //     Icons.edit,
          //     //     color: Colors.white,
          //     //   ),
          //     //   onPressed: () {},
          //     // ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.teal;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
