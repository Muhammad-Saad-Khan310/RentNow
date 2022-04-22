import 'package:flutter/material.dart';

import '../widgets/userProductsWidgets.dart';
import '../widgets/addProduct.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = "/user-products";
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 500,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return UserProductsWidget(
                      id: "c1",
                      title: "Camera",
                      imageUrl:
                          "https://cdn.mos.cms.futurecdn.net/JN4id4eQ79r4c4JzHVNtH5.jpg");
                },
                itemCount: 4,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddProduct.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
