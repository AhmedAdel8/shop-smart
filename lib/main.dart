import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/consts/theme_data.dart';
import 'package:shopsmart/providers/cart_provider.dart';
import 'package:shopsmart/providers/product_provider.dart';
import 'package:shopsmart/providers/theme_provider.dart';
import 'package:shopsmart/providers/user_provider.dart';
import 'package:shopsmart/providers/viewed_product_provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';
import 'package:shopsmart/root_screen.dart';
import 'package:shopsmart/screens/auth/forgot_password.dart';
import 'package:shopsmart/screens/auth/login.dart';
import 'package:shopsmart/screens/auth/register.dart';
import 'package:shopsmart/screens/inner_screens/orders/orders_screen.dart';
import 'package:shopsmart/screens/inner_screens/product_details.dart';
import 'package:shopsmart/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart/screens/inner_screens/wish_list.dart';
import 'package:shopsmart/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child:
                  SelectableText('An error has been occured ${snapshot.error}'),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishlistProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ViewedProdProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Shop Smart',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const LoginScreen(),
                //home: const RegisterScreen(),
                routes: {
                  ProductDetails.routeName: (context) {
                    return const ProductDetails();
                  },
                  WishListScreen.routeName: (context) {
                    return const WishListScreen();
                  },
                  ViewedRecentlyScreen.routeName: (context) {
                    return const ViewedRecentlyScreen();
                  },
                  RegisterScreen.routeName: (context) {
                    return const RegisterScreen();
                  },
                  LoginScreen.routeName: (context) {
                    return const LoginScreen();
                  },
                  OrdersScreen.routeName: (context) {
                    return const OrdersScreen();
                  },
                  ForgotPasswordScreen.routeName: (context) {
                    return const ForgotPasswordScreen();
                  },
                  SearchScreen.routeName: (context) {
                    return const SearchScreen();
                  },
                  RootScreen.routeName: (context) {
                    return const RootScreen();
                  },
                },
              );
            },
          ),
        );
      },
    );
  }
}
