import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rentnow/screens/user_products_screen.dart';
import './widgets/signup.dart';
import './widgets/becomeRenter.dart';
import './widgets/addProduct.dart';
import './widgets/rentItems.dart';
import './widgets/appDrawer.dart';
import 'widgets/login.dart';
import './widgets/product_overview.dart';

import './widgets/imageView.dart';
import 'widgets/login.dart';
import './widgets/practice.dart';
import 'widgets/userProductsWidgets.dart';
import './screens/categories_items_screen.dart';
import './widgets/categories_widgets.dart';
import './screens/user_products_screen.dart';
import './widgets/login.dart';

import './providers/items.dart';
import './screens/selected_category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Items(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Roboto",
        ),
        home: RentItem(),
        routes: {
          RentItem.routeName: (ctx) => RentItem(),
          BecomeRenter.routeName: (ctx) => BecomeRenter(),
          AddProduct.routeName: (ctx) => AddProduct(),
          SignUp.routeName: (ctx) => SignUp(),
          Login.routeName: (ctx) => Login(),
          ProductOverview.routeName: (ctx) => ProductOverview(),
          ImageView.routeName: (ctx) => ImageView(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          SelectedCategoryScreen.routeName: (ctx) => SelectedCategoryScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
