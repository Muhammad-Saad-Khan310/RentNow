import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/widgets/all_Item_widget.dart';

import '../providers/items.dart';

class AllItems extends StatelessWidget {
  static const routeName = "/all-items";
  const AllItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itmData = Provider.of<Items>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text("All Items"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: itmData.length,
            itemBuilder: (ctx, i) {
              return AllItemWidget(
                  id: itmData[i].id,
                  itemTitle: itmData[i].title,
                  rentPrice: itmData[i].price,
                  isAvailable: itmData[i].available,
                  itemImage: itmData[i].imageUrl,
                  address: itmData[i].address);
            }),
      ),
    );
  }
}
