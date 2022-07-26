import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import 'addProduct.dart';

class UserItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserItems(
      {Key? key, required this.id, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.18),
            blurRadius: 5,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.25,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image(
                // height: height * 0.08,
                // width: width * 0.25,
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                // width: width * 0.25,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddProduct.routeName, arguments: id);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () async {
                    try {
                      await Provider.of<Items>(context, listen: false)
                          .deleteItem(id);
                    } catch (error) {
                      print(error);

                      const snackBar = SnackBar(
                        content: Text("Item not Deleted"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
