import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appDrawer.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
  }
}
