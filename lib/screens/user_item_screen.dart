import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rentnow/widgets/userProductsWidgets.dart';
import 'package:rentnow/widgets/user_item.dart';
import '../providers/items.dart';
import '../widgets/appDrawer.dart';

class UserItemScreen extends StatefulWidget {
  static const routeName = "user-item";
  const UserItemScreen({Key? key}) : super(key: key);

  @override
  State<UserItemScreen> createState() => _UserItemScreenState();
}

class _UserItemScreenState extends State<UserItemScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Items>(
        context,
      ).fetchAndSetItems(true).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var userItem = Provider.of<Items>(context);
    var lstItem = userItem.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Items"),
      ),
      drawer: AppDrawer(),
      body: Container(
          child: ListView.builder(
              itemCount: lstItem.length,
              itemBuilder: ((context, i) {
                return UserItems(
                    id: lstItem[i].id,
                    imageUrl: lstItem[i].imageUrl,
                    title: lstItem[i].title);
                // UserProductsWidget(
                //     id: lstItem[i].id,
                //     title: lstItem[i].title,
                //     imageUrl: lstItem[i].imageUrl);
              }))),
    );
  }
}
