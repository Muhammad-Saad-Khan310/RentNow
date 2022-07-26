// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/contact.dart';
import './addProduct.dart';
import './login.dart';
import "../screens/user_item_screen.dart";
import "./help.dart";
import './rentItems.dart';
import './signup.dart';
import '../screens/profile_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<Auth>(context);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 30),
              alignment: Alignment.centerLeft,
              // ignore: deprecated_member_use
              color: Theme.of(context).accentColor,
              child: const Center(
                child: Text(
                  'RENT NOW!',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    // fontSize: 30,
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.home,
                // size: 35,
                color: Colors.teal,
              ),
              title: const Text("All Items"),
              onTap: () async {
                Navigator.of(context).pushNamed(RentItem.routeName);
              },
            ),
            userData.isAuth ? const Divider() : Container(),
            userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.add_box,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Add Item"),
                    onTap: () {
                      Navigator.of(context).pushNamed(AddProduct.routeName);
                    },
                  )
                : Container(),
            const Divider(),
            userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                      color: Colors.teal,
                    ),
                    title: const Text("My Items"),
                    onTap: () {
                      Navigator.of(context).pushNamed(UserItemScreen.routeName);
                    },
                  )
                : Container(),
            userData.isAuth ? const Divider() : Container(),
            userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.person,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Profile"),
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    })
                : Container(),
            userData.isAuth ? const Divider() : Container(),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.teal,
                // size: 35,
              ),
              title: const Text("Help"),
              onTap: () {
                Navigator.of(context).pushNamed(Help.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.contacts_sharp,
                color: Colors.teal,
                // size: 35,
              ),
              title: const Text("Contact Us"),
              onTap: () {
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
            ),
            !userData.isAuth ? const Divider() : Container(),
            !userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.login,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Login"),
                    onTap: () {
                      Navigator.of(context).pushNamed(Login.routeName);
                    },
                  )
                : Container(),
            userData.isAuth ? Container() : const Divider(),
            userData.isAuth
                ? Container()
                : ListTile(
                    leading: const Icon(
                      Icons.person_add,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Signup"),
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUp.routeName);
                    },
                  ),
            const Divider(),
            userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Logout"),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(Login.routeName);
                      userData.logout();
                    },
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}
