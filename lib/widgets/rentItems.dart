import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'userProductsWidgets.dart';
import './addProduct.dart';
import './userProfile.dart';
import '../screens/categories_items_screen.dart';
import '../providers/items.dart';

import './appDrawer.dart';

class RentItem extends StatefulWidget {
  static const routeName = '/all-Items';
  RentItem({Key? key}) : super(key: key);

  @override
  State<RentItem> createState() => _RentItemState();
}

class _RentItemState extends State<RentItem> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Items>(context).fetchAndSetItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  int currentIndex = 0;
  final List<Widget> appBarText = [
    Text("All Products"),
    Text("Your Products"),
    Text("Add Product"),
    Text("Profile")
  ];
  final List<Widget> _children = [
    // HomePage(),
    CategoriesItemsScreen(),
    // UserProductsWidget(),
    AddProduct(),
    UserProfile(),
  ];

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final items = <Widget>[
    //   const Icon(
    //     Icons.home,
    //     size: 30,
    //   ),
    //   const Icon(
    //     Icons.shopping_bag_rounded,
    //     size: 30,
    //   ),
    //   const Icon(
    //     Icons.add,
    //     size: 30,
    //   ),

    //   const Icon(
    //     Icons.person,
    //     size: 30,
    //   ),
    // ];
    return Scaffold(
      appBar: AppBar(
        title: appBarText[currentIndex],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CategoriesItemsScreen(),
      // bottomNavigationBar: Theme(
      //   data: Theme.of(context)
      //       .copyWith(iconTheme: IconThemeData(color: Colors.white)),
      //   child: CurvedNavigationBar(
      //     // buttonBackgroundColor: Colors.white,
      //     backgroundColor: Colors.transparent,
      //     color: Colors.blue,
      //     height: 60,
      //     index: currentIndex,
      //     items: items,
      //     onTap: onTappedBar,
      //   ),
      // ),
    );
  }
}
