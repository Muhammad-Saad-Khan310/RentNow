import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/all_items.dart';
import './screens/splash_screen.dart';
import './screens/user_item_screen.dart';

import './providers/auth.dart';

import './widgets/contact.dart';
import './widgets/help.dart';
import './widgets/item_detail.dart';
import './widgets/signup.dart';
import './widgets/becomeRenter.dart';
import './widgets/addProduct.dart';
import './widgets/rentItems.dart';
import './widgets/login.dart';
import './widgets/imageView.dart';
import './screens/profile_screen.dart';
import './widgets/update_renter.dart';
import './screens/categories_items_screen.dart';
import './widgets/reportProduct.dart';
import './providers/items.dart';
import './screens/selected_category_screen.dart';
import './providers/renter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Items>(
          create: (ctx) => Items("", "", "", []),
          update: (ctx, auth, previousProduct) => Items(
              auth.token ?? "",
              auth.userId ?? "",
              auth.userEmail ?? "",
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
          title: 'Rent Now',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: "Roboto",
          ),
          home: auth.isAuth
              ? const RentItem()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (
                    ctx,
                    authResultSnapshot,
                  ) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : const RentItem(),
                ),
          routes: {
            CategoriesItemsScreen.routeName: (ctx) =>
                const CategoriesItemsScreen(),
            RentItem.routeName: (ctx) => const RentItem(),
            BecomeRenter.routeName: (ctx) => const BecomeRenter(),
            AddProduct.routeName: (ctx) => const AddProduct(),
            SignUp.routeName: (ctx) => const SignUp(),
            Login.routeName: (ctx) => const Login(),
            ImageView.routeName: (ctx) => const ImageView(),
            SelectedCategoryScreen.routeName: (ctx) =>
                const SelectedCategoryScreen(),
            ProfileScreen.routeName: (ctx) => const ProfileScreen(),
            UpdateRenter.routeName: (ctx) => const UpdateRenter(),
            ReportProduct.routeName: (ctx) => const ReportProduct(),
            ItemDetail.routeName: (ctx) => const ItemDetail(),
            AllItems.routeName: (ctx) => const AllItems(),
            ContactUs.routeName: (ctx) => const ContactUs(),
            Help.routeName: (ctx) => const Help(),
            UserItemScreen.routeName: (ctx) => const UserItemScreen(),
          },
        ),
      ),
    );
  }
}
