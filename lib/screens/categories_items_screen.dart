// ignore_for_file: unnecessary_new, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/rentItems.dart';
import '../widgets/items_widget.dart';
import '../widgets/categories_widgets.dart';
import '../providers/item_categories.dart';
import '../providers/items.dart';
import '../providers/item.dart';
import './all_items.dart';

class CategoriesItemsScreen extends StatefulWidget {
  const CategoriesItemsScreen({Key? key}) : super(key: key);

  static const routeName = "/CategoriesItemsScreen";

  @override
  State<CategoriesItemsScreen> createState() => _CategoriesItemsScreenState();
}

class _CategoriesItemsScreenState extends State<CategoriesItemsScreen> {
  final controller = TextEditingController();
  var _showError = false;
  List<ProductItem> ltmData = [];
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Items>(context).fetchAndSetItems(false).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        // const errorMessage = "No Item found";

        setState(() {
          _isLoading = false;
          _showError = true;
        });
        // _showErrorDialog(errorMessage);
      }
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
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  void searchItem(String query) {
    if (query.isEmpty) {
      Navigator.of(context).pushReplacementNamed(RentItem.routeName);
    }
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
    final height = MediaQuery.of(context).size.height;
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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                    height: 140,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemBuilder: (ctx, index) {
                        String id;
                        String title;
                        String imageUrl;
                        id = categoryData[index].CategoryId;
                        title = categoryData[index].CategoryTitle;
                        imageUrl = categoryData[index].CategoryImage;
                        String categoryId = categoryData[index].CategoryId;

                        return CategoriesWidget(id, title, imageUrl, categoryId,
                            categoryData[index].CategoryTitle);
                      },
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                      // height: height * 0.03,
                      ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rent Items",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        _showError
                            ? Container()
                            : TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AllItems.routeName);
                                },
                                child: const Text("View all"))
                      ],
                    ),
                  ),
                  _showError
                      ? Center(
                          child: Text("No Item found"),
                        )
                      : ItemListView(ltmData),
                ],
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class ItemListView extends StatelessWidget {
  List<ProductItem> lst;

  ItemListView(this.lst, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.58,
      child: ListView.builder(
        shrinkWrap: false,
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
