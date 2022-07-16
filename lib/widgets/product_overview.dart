// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';
import 'package:rentnow/providers/auth.dart';
// import 'package:url_launcher/url_launcher.dart';
import './imageView.dart';
import "./reportProduct.dart";

import '../providers/items.dart';

class ProductOverview extends StatelessWidget {
  static const routeName = "/productOverview";
  const ProductOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    // Provider.of<Items>(context).items.firstWhere((prod) ==> prod.id == itemId);
    final loadedItem = Provider.of<Items>(context).findById(itemId);
    final userData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ImageView.routeName,
                  arguments: loadedItem.imageUrl);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(loadedItem.imageUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // "Canon DSLR",
                          loadedItem.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        loadedItem.available
                            ? const Text(
                                "Available",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )
                            : const Text(
                                "Not Available",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                        // const Text(
                        //   "10 Min ago",
                        //   style: TextStyle(color: Colors.blue, fontSize: 18),
                        // ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            loadedItem.address,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          // IconButton(
                          //     onPressed: () async {
                          //       var num = loadedItem.phoneNumber;
                          //       final Uri url = Uri.parse("tel://$num");
                          //       // launchUrl("tel://$num");
                          //       launchUrl(url);
                          //     },
                          //     icon: const Icon(
                          //       Icons.phone,
                          //       color: Colors.blue,

                          //     )),
                          GestureDetector(
                            onTap: () {
                              // var num = loadedItem.phoneNumber;
                              // final Uri url = Uri.parse("tel://$num");
                              // // launchUrl("tel://$num");
                              // launchUrl(url);
                            },
                            child: const Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            loadedItem.phoneNumber,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 14),
                          child: const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          // padding: EdgeInsets.fromLTRB(0, 25, 0, 46),
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(loadedItem.description),
                        )
                      ],
                    ),
                    Expanded(
                        child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(249, 251, 252, 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "RS:   " + loadedItem.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            // Text(
                            //   loadedItem.available,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Provider.of<Auth>(context, listen: false).isAuth
                                ? ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          ReportProduct.routeName,
                                          arguments: {
                                            "image": loadedItem.imageUrl,
                                            "itemID": loadedItem.id,
                                            "ownerEmail": loadedItem.userEmail,
                                          });
                                    },
                                    child: const Text("Report Item"))
                                : Container()
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
