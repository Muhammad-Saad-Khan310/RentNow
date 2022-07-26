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
    // ignore: unused_local_variable
    final id = routeArgs["categoryId"].toString();
    final title = routeArgs["categoryTitle"].toString();
    final loadedData = Provider.of<Items>(context).findCategoryItem(title);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: loadedData.isEmpty
              ? const Center(child: Text("No Item Found in this category"))
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ItemsWidget(
                      id: loadedData[index].id,
                      itemTitle: loadedData[index].title,
                      itemImage: loadedData[index].imageUrl,
                      rentPrice: loadedData[index].price,
                      isAvailable: loadedData[index].available,
                    );
                  },
                  itemCount: loadedData.length,
                ),
        ));
  }
}
