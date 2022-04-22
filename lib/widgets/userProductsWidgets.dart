import 'package:flutter/material.dart';

class UserProductsWidget extends StatelessWidget {
  // static const routeName = "/user-products";
  // const UserProductsWidget({Key? key}) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  UserProductsWidget(
      {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(211, 218, 222, 100),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey)),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 0.0),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0)),
              child: Image.network(imageUrl, fit: BoxFit.scaleDown),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}