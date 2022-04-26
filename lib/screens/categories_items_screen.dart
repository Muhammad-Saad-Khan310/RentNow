// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/items_widget.dart';
import '../widgets/categories_widgets.dart';
import '../providers/product_categories.dart';
import '../providers/items.dart';

class CategoriesItemsScreen extends StatefulWidget {
  const CategoriesItemsScreen({Key? key}) : super(key: key);

  static const routeName = "/CategoriesItemsScreen";

  @override
  State<CategoriesItemsScreen> createState() => _CategoriesItemsScreenState();
}

class _CategoriesItemsScreenState extends State<CategoriesItemsScreen> {
  Widget InputField(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: text,
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 100),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

//   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            InputField("Search"),
            const Text(
              "Search By Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              height: 170,
              child: ListView.builder(
                shrinkWrap: false,
                // padding: EdgeInsets.zero,
                itemBuilder: (ctx, index) {
                  String id;
                  String title;
                  String imageUrl;
                  id = categoryData[index].CategoryId;
                  title = categoryData[index].CategoryTitle;
                  imageUrl = categoryData[index].CategoryImage;
                  String categoryId = categoryData[index].CategoryId;
                  // categoryData.map((catData) => CategoriesWidget()).toList();
                  return CategoriesWidget(id, title, imageUrl, categoryId,
                      categoryData[index].CategoryTitle);
                },
                itemCount: 4,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Rent Now",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ItemListView(),
          ],
        ),
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  const ItemListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemData = Provider.of<Items>(context);
    final item = ItemData.items;
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 500,
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (ctx, index) {
          return ItemsWidget(
            id: item[index].id,
            itemTitle: item[index].title,
            itemImage: item[index].imageUrl,
            rentPrice: item[index].price,
          );
        },
      ),
    );
  }
}
