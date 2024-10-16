import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/wishlist_provider.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/services/my_app_method.dart';
import 'package:shopsmart/widgets/empty_bag.dart';
import 'package:shopsmart/widgets/products/product_widget.dart';
import 'package:shopsmart/widgets/title_text.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/WishListScreen';
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagepath: AssetsManager.bagWish,
              title: 'Your Wishlist is empty',
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: 'Shop Now',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                  label:
                      'Wishlist (${wishlistProvider.getWishlistItems.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconlyLight.arrowLeft2),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethod.showErrorORWarininginDialog(
                        context: context,
                        subtitle: "Remove items",
                        fct: () {
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Expanded(
              child: DynamicHeightGridView(
                builder: (context, index) {
                  return ProductWidget(
                    productId: wishlistProvider.getWishlistItems.values
                        .toList()[index]
                        .productId,
                  );
                },
                itemCount: wishlistProvider.getWishlistItems.length,
                crossAxisCount: 2,
              ),
            ),
          );
  }
}
