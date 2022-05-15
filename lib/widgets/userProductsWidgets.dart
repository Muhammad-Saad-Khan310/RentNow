import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './addProduct.dart';
import '../providers/items.dart';

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
    final scaffold = Scaffold.of(context);
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
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddProduct.routeName, arguments: id);
                    },
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Alert!"),
                            content: const Text(
                                "Are you sure You want to Delete this Item?"),
                            actions: [
                              FlatButton(
                                child: const Text("Yes"),
                                onPressed: () async {
                                  try {
                                    Navigator.of(context).pop();
                                    await Provider.of<Items>(context,
                                            listen: false)
                                        .deleteItem(id);
                                  } catch (error) {
                                    scaffold.showSnackBar(
                                      const SnackBar(
                                        content: Text("Deleting failed"),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      }
                      // onPressed: () async {
                      // try {
                      //   await Provider.of<Items>(context, listen: false)
                      //       .deleteItem(id);
                      // } catch (error) {
                      //   scaffold.showSnackBar(
                      //     const SnackBar(
                      //       content: Text("Deleting failed"),
                      //     ),
                      //   );
                      // }
                      // },
                      // color: Colors.red,
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
