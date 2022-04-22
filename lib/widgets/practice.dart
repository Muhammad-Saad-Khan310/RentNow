import 'package:flutter/material.dart';
import './categories_widgets.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  Widget presentText(String text) {
    return Column(
      children: [Text("Some text")],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return CategoriesWidget("s", "d", "s", "s");
        },
        itemCount: 3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
