import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_item.dart';
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
  var _showMessage = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Items>(context).fetchAndSetItems(true).then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
          _showMessage = true;
        });
      }
    }
    _isInit = false;

    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var userItem = Provider.of<Items>(context);
    var lstItem = userItem.userItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Items"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _showMessage
              ? const Center(
                  child: Text("No item found "),
                )
              : ListView.builder(
                  itemCount: lstItem.length,
                  itemBuilder: ((context, i) {
                    return UserItems(
                        id: lstItem[i].id,
                        imageUrl: lstItem[i].imageUrl,
                        title: lstItem[i].title);
                  })),
    );
  }
}
