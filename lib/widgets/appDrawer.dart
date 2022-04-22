import 'package:flutter/material.dart';
import './addProduct.dart';
import './login.dart';

import './rentItems.dart';
import './becomeRenter.dart';
import './signup.dart';
import './product_overview.dart';

import 'signup.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Rent Now"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("All Products"),
            onTap: () {
              Navigator.of(context).pushNamed(RentItem.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_rounded),
            title: Text("Become Renter"),
            onTap: () {
              Navigator.of(context).pushNamed(BecomeRenter.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text("Add Product"),
            onTap: () {
              Navigator.of(context).pushNamed(AddProduct.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text("SignUp"),
            onTap: () {
              Navigator.of(context).pushNamed(SignUp.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: () {
              Navigator.of(context).pushNamed(Login.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.details),
            title: Text("Product Details"),
            onTap: () {
              Navigator.of(context).pushNamed(ProductOverview.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("User Products"),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductsScreen.routeName);
            },
          ),
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
