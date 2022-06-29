import 'package:flutter/material.dart';
import 'package:rentnow/widgets/appDrawer.dart';
import '../widgets/new.dart';

import 'package:provider/provider.dart';
import '../providers/renter.dart';
import '../widgets/userProfile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/user-profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInit = true;

  var _isLoading = false;
  // List<RenterClass> screenData = [
  //   RenterClass(
  //       id: "id",
  //       userName: "userName",
  //       dateOfBirth: "dateOfBirth",
  //       phoneNumber: "phoneNumber",
  //       address: "address",
  //       imageUrl:
  //           "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
  // ];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Renter>(context).getUserProfile().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _refreshItem() async {
    await Provider.of<Renter>(context, listen: false).fetchRenter();
  }

  @override
  Widget build(BuildContext context) {
    // var renterData = Provider.of<Renter>(context).fetchRenter();
    // screenData = renterData.rentItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshItem,
              child: FutureBuilder(
                future: _refreshItem(),
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<Renter>(
                            builder: (ctx, renterData, _) => UserProfile(
                                renterData.rentItems[0].id,
                                renterData.rentItems[0].userName,
                                renterData.rentItems[0].dateOfBirth,
                                renterData.rentItems[0].phoneNumber,
                                renterData.rentItems[0].address,
                                renterData.rentItems[0].imageUrl),
                          ),
              ),
            ),
    );

    // final renterData = Provider.of<Renter>(context);
    // // final data = renterData.getUserProfile();
    // final screenData = renterData.rentItems;
    // print("zzzzzzzzzzzzzzz");
    // print(zamungdata);
    // print("zzzzzzzzzzzzzzzzzzzz");
    // return FutureBuilder(
    //     future: renterData.getUserProfile(),
    //     builder: (ctx, snapshot) =>
    //         snapshot.connectionState == ConnectionState.waiting
    //             ? Center(
    //                 child: CircularProgressIndicator(),
    //               )
    //             : ProfilePage(screenData["userName"], screenData["dateOfBirth"],
    //                 screenData["phoneNumber"], screenData["address"]));
    // return _isLoading
    //     ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : UserProfile(
    //         screenData[0].id,
    //         screenData[0].userName,
    //         screenData[0].dateOfBirth,
    //         screenData[0].phoneNumber,
    //         screenData[0].address,
    //         screenData[0].imageUrl);
    // : ProfilePage(
    //     screenData[0].id,
    //     screenData[0].userName,
    //     screenData[0].dateOfBirth,
    //     screenData[0].phoneNumber,
    //     screenData[0].address,
    //     screenData[0].imageUrl);
  }
}
