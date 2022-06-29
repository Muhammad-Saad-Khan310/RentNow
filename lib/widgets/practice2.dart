import 'package:flutter/material.dart';

class Practice2 extends StatelessWidget {
  const Practice2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("clip")),
      body: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(color: Colors.red),
          child: Text("clip Path"),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double w = size.width;
    // double h = size.height;
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);
    // path.lineTo(0, h);
    // path.quadraticBezierTo(w, h, 0, 0);
    // path.lineTo(w, h);
    // path.lineTo(w, 0);
    // // from 1 to 5 line is created by close button
    // path.close();
    return path;
    // TODO: implement getClip
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
