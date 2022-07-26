import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  static const routeName = "/help";
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Help")),
      body: SingleChildScrollView(
        child: Container(
            height: height * 0.35,
            padding:
                const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
            margin: const EdgeInsets.only(
              top: 80,
              right: 15,
              left: 15,
            ),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Process",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Text(
                      "In This App Users can upload their items with the required data of the items, then the data is sended to Admin portal, then the admin portal review the uploaded data, if the data are valid then the Admin will approve the item posting, if the data are not valid then the admin delete the item . Every user can search item of their own choice. Owner contact number are available with the item, so the users can easily access to their needed items."),
                )
              ],
            )),
      ),
    );
  }
}
