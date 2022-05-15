import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import '../widgets/userProductsWidgets.dart';
import '../widgets/appDrawer.dart';
import '../widgets/addProduct.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = "/user-products";
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  Future<void> _refreshItem() async {
    await Provider.of<Items>(context, listen: false).fetchAndSetItems(true);
  }

  @override
  Widget build(BuildContext context) {
    // final items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshItem,
        child: FutureBuilder(
          future: _refreshItem(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<Items>(
                      builder: (ctx, itemData, _) => Padding(
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
                                      id: itemData.items[index].id,
                                      title: itemData.items[index].title,
                                      imageUrl: itemData.items[index].imageUrl);
                                },
                                itemCount: itemData.items.length,
                              ),
                            ),
                            // Align(
                            //   alignment: FractionalOffset.bottomCenter,
                            //   child: Padding(
                            //     padding:
                            //         const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                            //     child: FloatingActionButton(
                            //       child: Icon(Icons.add),
                            //       onPressed: () {
                            //         Navigator.of(context).pushNamed(AddProduct.routeName);
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
