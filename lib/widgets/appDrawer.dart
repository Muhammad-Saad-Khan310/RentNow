import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/widgets/contact.dart';
import 'package:rentnow/widgets/update_renter.dart';
import 'package:rentnow/widgets/userProfile.dart';
import './addProduct.dart';
import './login.dart';

import "./help.dart";

import './rentItems.dart';
import './becomeRenter.dart';
import './signup.dart';
import './product_overview.dart';

import '../screens/profile_screen.dart';
import '../widgets/new.dart';

import 'signup.dart';
import '../providers/auth.dart';
import '../providers/renter.dart';
import '../providers/items.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void _showErrorDialog(String message, ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert!"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(ctx).pushReplacementNamed(BecomeRenter.routeName);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<Auth>(context);
    var renterData = Provider.of<Renter>(context);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // AppBar(
            //   title: const Text("Rent Now"),
            //   automaticallyImplyLeading: false,
            // ),
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 30),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Center(
                child: const Text(
                  'RENT NOW!',
                  style: TextStyle(
                    // fontWeight: FontWeight.w900,
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

            // ListTile(
            //   leading: const Icon(Icons.add_box),
            //   title: const Text("Add Product"),
            //   onTap: () {
            //     if (userData.isAllowed) {
            //       Navigator.of(context).pushNamed(AddProduct.routeName);
            //     } else {
            //       String errorMessage = "Please login first then add product";
            //       _showErrorDialog(errorMessage, context);
            //     }
            //   },
            // ),
            // FutureBuilder<bool>(
            //     future: renterData.showAddProductForm(),
            //     builder: (ctx, AsyncSnapshot<bool> snapshot) {
            //       if (snapshot.data == true) {
            //         return ListTile(
            //           leading: const Icon(Icons.add_box),
            //           title: const Text("Add Product"),
            //           onTap: () {
            //             Navigator.of(context).pushNamed(AddProduct.routeName);
            //           },
            //         );
            //       } else {
            //         return const Text("");
            //       }
            //     }),
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

            // userData.isAuth
            //     ? ListTile(
            //         leading: const Icon(
            //           Icons.add_box,
            //           color: Colors.teal,
            //         ),
            //         title: const Text("Add Product"),
            //         onTap: () {
            //           renterData.showAddProductForm().then((value) => {
            //                 if (value)
            //                   {
            //                     Navigator.of(context)
            //                         .pushNamed(AddProduct.routeName)
            //                   }
            //                 else
            //                   {
            //                     // String errorMessage =
            //                     // "Please fill become renter then add product";
            //                     _showErrorDialog(
            //                         "Please provide become renter data then add product",
            //                         context)
            //                   }
            //               });

            // FutureBuilder<bool>(
            //   future: renterData.showAddProductForm(),
            //   builder: (ctx, AsyncSnapshot<bool> snapshot) {
            //     if (snapshot.data == true) {
            //       Navigator.of(context).pushNamed(AddProduct.routeName);

            //       // ListTile(
            //       //   leading: const Icon(Icons.add_box),
            //       //   title: const Text("Add Product"),
            //       //   onTap: () {
            //       //     ;
            //       //   },
            //       // );
            //     } else {
            //       String errorMessage =
            //           "Please fill become renter then add product";
            //       _showErrorDialog(errorMessage, context);
            //     }
            //     return const Text("saf");
            //   },
            // );
            // },
            // )
            // : Container(),

            const Divider(),
            userData.isAuth
                ? ListTile(
                    leading: const Icon(
                      Icons.person,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("User Profile"),
                    onTap: () {
                      print(userData.userId);
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    })
                : Container(),

            userData.isAuth ? const Divider() : Container(),

            // renterData.showAddProductForm().then((value) => {

            // }
            // )

            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.teal,
                // size: 35,
              ),
              title: Text("Help"),
              onTap: () {
                Navigator.of(context).pushNamed(Help.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.contacts_sharp,
                color: Colors.teal,
                // size: 35,
              ),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
            ),
            // Divider(),
            userData.isAuth ? Container() : Divider(),
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
                      Icons.shopping_bag,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("My Items"),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UserProductsScreen.routeName);
                    },
                  )
                : ListTile(
                    leading: const Icon(
                      Icons.login,
                      // size: 35,
                      color: Colors.teal,
                    ),
                    title: const Text("Login"),
                    onTap: () {
                      Navigator.of(context).pushNamed(Login.routeName);
                    },
                  ),
            // const Divider(),

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
                      Navigator.of(context).pushReplacementNamed("/");
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
