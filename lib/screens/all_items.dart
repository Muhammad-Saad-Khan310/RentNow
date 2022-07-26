import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import '../widgets/items_widget.dart';

class AllItems extends StatelessWidget {
  static const routeName = "/all-items";
  const AllItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itmData = Provider.of<Items>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Items"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView.builder(
            itemCount: itmData.length,
            itemBuilder: (ctx, index) {
              return ItemsWidget(
                id: itmData[index].id,
                itemTitle: itmData[index].title,
                itemImage: itmData[index].imageUrl,
                rentPrice: itmData[index].price,
                isAvailable: itmData[index].available,
              );
            }),
      ),
    );
  }
}
