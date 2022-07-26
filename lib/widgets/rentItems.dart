// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../screens/categories_items_screen.dart';
import './appDrawer.dart';

class RentItem extends StatefulWidget {
  static const routeName = '/all-Items';
  const RentItem({Key? key}) : super(key: key);

  @override
  State<RentItem> createState() => _RentItemState();
}

class _RentItemState extends State<RentItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const AppDrawer(),
      body: const CategoriesItemsScreen(),
    );
  }
}
