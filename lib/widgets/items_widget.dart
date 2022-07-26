import 'package:flutter/material.dart';

import './item_detail.dart';

class ItemsWidget extends StatelessWidget {
  final String id;
  final String itemTitle;
  final String itemImage;
  final String rentPrice;
  final bool isAvailable;

  const ItemsWidget(
      {Key? key,
      required this.id,
      required this.itemTitle,
      required this.itemImage,
      required this.rentPrice,
      required this.isAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ItemDetail.routeName,
              arguments: id,
            );
          },
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 222, 230, 235),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Hero(
                              tag: id,
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                  "assets/images/placeholder.png",
                                ),
                                image: NetworkImage(
                                  itemImage,
                                ),
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: isAvailable
                                ? const Text(
                                    "Available",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  )
                                : const Text(
                                    "Not Available",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemTitle,
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            "RS " + rentPrice,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
