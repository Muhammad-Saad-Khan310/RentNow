import "package:flutter/material.dart";
import "../widgets/item_detail.dart";

class AllItemWidget extends StatelessWidget {
  final String id;
  final String itemTitle;
  final String itemImage;
  final String rentPrice;
  final bool isAvailable;
  final String address;
  // const NewFile({Key? key}) : super(key: key);
  AllItemWidget(
      {required this.id,
      required this.itemTitle,
      required this.rentPrice,
      required this.isAvailable,
      required this.itemImage,
      required this.address});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var colorAvailble = Color.fromARGB(255, 39, 238, 46);
    if (isAvailable) {
      // colorAvailble = Color.fromARGB(255, 39, 238, 39);
      // colorAvailble = Color.fromRGBO(170, 255, 202, 1);
      colorAvailble = Colors.lightGreen;
    } else {
      // colorAvailble = Color.fromARGB(255, 255, 28, 1);
      colorAvailble = Color.fromARGB(255, 255, 84, 84);
    }
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 10,
        child: Container(
          // margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          width: width * 0.7,
          height: height * 0.28,
          decoration: BoxDecoration(
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //       color: Colors.black54,
            //       blurRadius: 15.0,
            //       offset: Offset(-0.0, -0.75))
            // ],
            borderRadius: BorderRadius.circular(8),
            // color: Colors.grey[100]
            // color: Color.fromRGBO(224, 255, 236, 1),
            color: Color.fromARGB(255, 222, 230, 235),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 5,
                right: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ItemDetail.routeName,
                            arguments: id,
                          );
                        },
                        child: Image(
                          image: NetworkImage(
                              // "https://www.qwer.pk/wp-content/uploads/2020/05/8DB4AFDB-71A1-46C8-9C86-388B5019FDAE-scaled.jpeg"
                              itemImage),
                          fit: BoxFit.cover,
                          width: width,
                          height: height * 0.18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemTitle,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              address,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Rs:",
                              style: TextStyle(
                                  // color: Color.fromRGBO(67, 172, 106, 1)
                                  ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              rentPrice,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 30,
                  decoration: BoxDecoration(
                      color: colorAvailble,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(10))),
                  child: isAvailable
                      ? Text(
                          "Available",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text("Not Available",
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
