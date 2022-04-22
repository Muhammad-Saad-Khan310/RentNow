import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  static const routeName = "/image-view";
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.scaleDown)),
      ),
    );
  }
}
