import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/providers/viewed_product_provider.dart';
import 'package:shopsmart/services/assets_manager.dart';
import 'package:shopsmart/services/my_app_method.dart';
import 'package:shopsmart/widgets/empty_bag.dart';
import 'package:shopsmart/widgets/products/product_widget.dart';
import 'package:shopsmart/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routeName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProdProvider>(context);

    return viewedProvider.getViewedProdItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagepath: AssetsManager.shoppingBasket,
              title: 'Your Viewed recently is empty',
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: 'Shop Now',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                  label:
                      'Viewed Recently (${viewedProvider.getViewedProdItems.length})'),
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
                          viewedProvider.clearLocalViewed();
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductWidget(
                      productId: viewedProvider.getViewedProdItems.values
                          .toList()[index]
                          .productId,
                    ),
                  );
                },
                itemCount: viewedProvider.getViewedProdItems.length,
                crossAxisCount: 2,
              ),
            ),
          );
  }
}
