import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/items_widget.dart';
import '../providers/items.dart';

class SelectedCategoryScreen extends StatefulWidget {
  static const routeName = "/Selected_Category";
  const SelectedCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SelectedCategoryScreen> createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final id = routeArgs["categoryId"].toString();
    final title = routeArgs["categoryTitle"];
    final loadedData = Provider.of<Items>(context).findCategoryItem(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(title as String),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, left: 15.0, right: 15.0, bottom: 25),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return ItemsWidget(
                  id: loadedData[index].id,
                  itemTitle: loadedData[index].title,
                  itemImage: loadedData[index].imageUrl,
                  rentPrice: loadedData[index].price);
            },
            itemCount: loadedData.length,
          ),
        ));
  }
}
