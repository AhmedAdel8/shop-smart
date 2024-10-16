import 'package:flutter/material.dart';
import 'package:shopsmart/models/viewed_product_model.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedprodItems = {};
  Map<String, ViewedProdModel> get getViewedProdItems {
    return _viewedprodItems;
  }

  // bool isProductInViewedProd({required String productId}) {
  //   return _viewedprodItems.containsKey(productId);
  // }

  void addproductToHistory({required String productId}) {
    _viewedprodItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearLocalViewed() {
    _viewedprodItems.clear();
    notifyListeners();
  }
}
