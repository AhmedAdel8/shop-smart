import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/consts/app_colors.dart';
import 'package:shopsmart/models/user_model.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/providers/user_provider.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/inner_screens/orders/orders_screen.dart';
import 'package:shopsmart/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screens/wish_list.dart';
import 'package:shopsmart/screens/loading_manager.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/services/my_app_method.dart';
import 'package:shopsmart/widgets/Custom_list_tile.dart';
import 'package:shopsmart/widgets/app_name_text.dart';
import 'package:shopsmart/widgets/subtitle_text.dart';
import 'package:shopsmart/widgets/title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  UserModel? userModel;
  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethod.showErrorORWarininginDialog(
        context: context,
        subtitle: "An error has been occured $error",
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: TitleTextWidget(
                    label: 'please login to have ultimate access',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: AppColors.darkPrimary,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextWidget(
                                label: userModel!.userName,
                              ),
                              SubtitleTextWidget(
                                label: userModel!.userEmail,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleTextWidget(
                      label: 'General',
                    ),
                    userModel == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagepath: AssetsManager.orderSvg,
                            text: 'All orders',
                            function: () async {
                              await Navigator.pushNamed(
                                  context, OrdersScreen.routeName);
                            },
                          ),
                    userModel == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagepath: AssetsManager.wishlistSvg,
                            text: 'wishlist',
                            function: () {
                              Navigator.pushNamed(
                                  context, WishListScreen.routeName);
                            },
                          ),
                    CustomListTile(
                      imagepath: AssetsManager.recent,
                      text: 'viewed recently',
                      function: () {
                        Navigator.pushNamed(
                            context, ViewedRecentlyScreen.routeName);
                      },
                    ),
                    CustomListTile(
                      imagepath: AssetsManager.address,
                      text: 'Address',
                      function: () {},
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TitleTextWidget(
                      label: 'Settings',
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SwitchListTile(
                      secondary: Image.asset(
                        AssetsManager.theme,
                        height: 30,
                      ),
                      title: Text(themeProvider.getIsDarkTheme
                          ? 'Dark mode'
                          : 'Light mode'),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themevalue: value);
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (user == null) {
                            await Navigator.pushNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          } else {
                            await MyAppMethod.showErrorORWarininginDialog(
                              context: context,
                              subtitle: 'Are you sure?',
                              fct: () async {
                                await FirebaseAuth.instance.signOut();
                                if (!mounted) return;
                                await Navigator.pushNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              },
                              isError: false,
                            );
                          }
                        },
                        icon: Icon(
                          user == null ? Icons.login : Icons.logout,
                          color: Colors.white,
                        ),
                        label: Text(
                          user == null ? 'Login' : 'Logout',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
