import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/screens/splash_screen.dart';
import 'package:rentnow/widgets/userProfile.dart';
import './providers/auth.dart';

import '/screens/user_products_screen.dart';
import './widgets/signup.dart';
import './widgets/becomeRenter.dart';
import './widgets/addProduct.dart';
import './widgets/rentItems.dart';

import 'widgets/login.dart';
import './widgets/product_overview.dart';

import './widgets/imageView.dart';
import './screens/profile_screen.dart';
import 'widgets/login.dart';
import './widgets/practice.dart';
import './widgets/update_renter.dart';
import './screens/categories_items_screen.dart';
import './widgets/categories_widgets.dart';
import './screens/user_products_screen.dart';
import './widgets/reportProduct.dart';

import './providers/items.dart';
import './screens/selected_category_screen.dart';
import './providers/renter.dart';
import './widgets/new.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './widgets/practice2.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Items>(
          create: (ctx) => Items("", "", []),
          update: (ctx, auth, previousProduct) => Items(
              auth.token ?? "",
              auth.userId ?? "",
              previousProduct == null ? [] : previousProduct.items),
        ),
        ChangeNotifierProxyProvider<Auth, Renter>(
          create: (ctx) => Renter("", ""),
          update: (ctx, auth, previousData) =>
              Renter(auth.userId ?? "", auth.token ?? ""),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            primarySwatch: Colors.teal,

            fontFamily: "Roboto",
          ),

          // home: Practice(),

          home: auth.isAuth
              ? RentItem()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (
                    ctx,
                    authResultSnapshot,
                  ) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : RentItem(),
                ),
          // home: ProfilePage(),
          routes: {
            CategoriesItemsScreen.routeName: (ctx) =>
                const CategoriesItemsScreen(),
            RentItem.routeName: (ctx) => RentItem(),
            BecomeRenter.routeName: (ctx) => BecomeRenter(),
            AddProduct.routeName: (ctx) => AddProduct(),
            SignUp.routeName: (ctx) => SignUp(),
            Login.routeName: (ctx) => Login(),
            ProductOverview.routeName: (ctx) => ProductOverview(),
            ImageView.routeName: (ctx) => ImageView(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            SelectedCategoryScreen.routeName: (ctx) => SelectedCategoryScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            UpdateRenter.routeName: (ctx) => UpdateRenter(),
            ReportProduct.routeName: (ctx) => ReportProduct(),
          },
        ),
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
