import 'package:flutter/material.dart';
import './product_overview.dart';

class ItemsWidget extends StatelessWidget {
  final String id;
  // final String categoryTitle;
  final String itemTitle;
  // final String categoryImage;
  final String itemImage;
  final String rentPrice;

  // const Categores_Items({ Key? key }) : super(key: key);
  ItemsWidget(
      {required this.id,
      // required this.categoryTitle,
      required this.itemTitle,
      // required this.categoryImage,
      required this.itemImage,
      required this.rentPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductOverview.routeName,
              arguments: id,
            );
          },
          child: Column(
            children: [
              Card(
                color: const Color.fromRGBO(40, 169, 254, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            itemImage,
                            // height: 250,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.0))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: const Text(
                              "Available",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemTitle,
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            "RS " + "$rentPrice",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
