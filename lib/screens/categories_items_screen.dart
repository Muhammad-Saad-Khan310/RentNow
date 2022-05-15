// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/widgets/rentItems.dart';
import '../widgets/items_widget.dart';
import '../widgets/categories_widgets.dart';
import '../providers/product_categories.dart';
import '../providers/items.dart';
import '../providers/item.dart';

class CategoriesItemsScreen extends StatefulWidget {
  const CategoriesItemsScreen({Key? key}) : super(key: key);

  static const routeName = "/CategoriesItemsScreen";

  @override
  State<CategoriesItemsScreen> createState() => _CategoriesItemsScreenState();
}

class _CategoriesItemsScreenState extends State<CategoriesItemsScreen> {
  final controller = TextEditingController();
  // var u = Provider.of<Items>(context);
  List<ProductItem> ltmData = [];
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

  InputDecoration fieldDecoration(String text) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.search),
      labelText: text,
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 100),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  void searchItem(String query) {
    final suggestion = ltmData.where((element) {
      final itemTitle = element.title.toLowerCase();
      final input = query.toLowerCase();

      return itemTitle.contains(input);
    }).toList();
    setState(() {
      ltmData = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Itm = Provider.of<Items>(context);
    if (ltmData.isEmpty) {
      ltmData = Itm.items;
    }

    return RefreshIndicator(
      onRefresh: () {
        return Navigator.of(context).pushReplacementNamed(RentItem.routeName);
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    // InputField("Search"),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: fieldDecoration("Search"),
                        onChanged: searchItem,
                      ),
                    ),
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
                          return CategoriesWidget(id, title, imageUrl,
                              categoryId, categoryData[index].CategoryTitle);
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
                    ItemListView(ltmData),
                  ],
                ),
              ),
            ),
    );
  }
}

class ItemListView extends StatelessWidget {
  List<ProductItem> lst;
  // const ItemListView({
  //   Key? key,
  // }) : super(key: key);
  ItemListView(this.lst);
  @override
  Widget build(BuildContext context) {
    // final ItemData = Provider.of<Items>(context);
    // final item = ItemData.fetchAndSetItems();
    // final lst = ItemData.items;
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 500,
      child: ListView.builder(
        itemCount: lst.length,
        itemBuilder: (ctx, index) {
          return ItemsWidget(
            id: lst[index].id,
            itemTitle: lst[index].title,
            itemImage: lst[index].imageUrl,
            rentPrice: lst[index].price,
            isAvailable: lst[index].available,
          );
        },
      ),
    );
  }
}
