import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import './imageView.dart';
import "./reportProduct.dart";
import '../providers/items.dart';

class ItemDetail extends StatelessWidget {
  static const routeName = "/itemOverview";
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedItem = Provider.of<Items>(context).findById(itemId);
    // ignore: unused_local_variable
    final userData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(ImageView.routeName,
                        arguments: loadedItem.imageUrl);
                  }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Hero(
                      tag: itemId,
                      child: Image(
                        image: NetworkImage(loadedItem.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loadedItem.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            loadedItem.available
                                ? const Text(
                                    "Available",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : const Text(
                                    "Not Available",
                                    style: TextStyle(color: Colors.red),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  var num = loadedItem.phoneNumber;
                                  final Uri url = Uri.parse("tel://$num");

                                  launchUrl(url);
                                },
                                child: const Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.green,
                                )),
                            // Icon(Icons.phone_android),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(loadedItem.phoneNumber)
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(loadedItem.description),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "RS:  " + loadedItem.price,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Provider.of<Auth>(context, listen: false)
                                            .isAuth
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  ReportProduct.routeName,
                                                  arguments: {
                                                    "image":
                                                        loadedItem.imageUrl,
                                                    "itemID": loadedItem.id,
                                                    "itemOwnerEmail":
                                                        loadedItem.userEmail,
                                                  });
                                            },
                                            child: const Text("Report Item"))
                                        : Container(),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
