import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './addProduct.dart';
import './login.dart';

import './rentItems.dart';
import './becomeRenter.dart';
import './signup.dart';
import './product_overview.dart';

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
          FlatButton(
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
      child: Column(
        children: [
          AppBar(
            title: const Text("Rent Now"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("All Products"),
            onTap: () async {
              await Provider.of<Items>(context, listen: false)
                  .fetchAndSetItems();
              Navigator.of(context).pushNamed(RentItem.routeName);
            },
          ),

          const Divider(),
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
          userData.isAllowed
              ? ListTile(
                  leading: const Icon(Icons.add_box),
                  title: const Text("Add Product"),
                  onTap: () {
                    renterData.showAddProductForm().then((value) => {
                          if (value)
                            {
                              Navigator.of(context)
                                  .pushNamed(AddProduct.routeName)
                            }
                          else
                            {
                              // String errorMessage =
                              // "Please fill become renter then add product";
                              _showErrorDialog(
                                  "Please provide become renter data then add product",
                                  context)
                            }
                        });

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
                  },
                )
              : Text(""),

          const Divider(),

          FutureBuilder<bool>(
              future: renterData.userType(),
              builder: (ctx, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == true) {
                  return ListTile(
                    leading: const Icon(Icons.person_pin_rounded),
                    title: const Text("Become Renter"),
                    onTap: () {
                      Navigator.of(context).pushNamed(BecomeRenter.routeName);
                    },
                  );
                } else {
                  return const Text("");
                }
              }),
          const Divider(),

          // renterData
          //     ? ListTile(
          //         leading: const Icon(Icons.person_pin_rounded),
          //         title: const Text("Become Renter"),
          //         onTap: () {
          //           Navigator.of(context).pushNamed(BecomeRenter.routeName);
          //         },
          //       )
          //     : Text("some"),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text("SignUp"),
            onTap: () {
              Navigator.of(context).pushNamed(SignUp.routeName);
            },
          ),

          const Divider(),
          userData.isAllowed
              ? ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("My Items"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserProductsScreen.routeName);
                    // Navigator.of(context)
                    // .pushReplacementNamed(UserProductsScreen.routeName);
                    // Navigator.of(context)
                    //     .pushNamed(UserProductsScreen.routeName);
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text("Login"),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                  },
                ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.person_pin_rounded),
          //   title: const Text("Become Renter"),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(BecomeRenter.routeName);
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.details),
          //   title: const Text("Product Details"),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(ProductOverview.routeName);
          //   },
          // ),
          const Divider(),
          userData.isAllowed
              ? ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Logout"),
                  onTap: () {
                    userData.logout();
                    Navigator.of(context).pushNamed(RentItem.routeName);
                  },
                )
              : const Text("")
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.person_add),
          //   title: Text("New Sign Up"),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(NewSignUp.routeName);
          //   },
          // )
        ],
      ),
    );
  }
}
