import 'package:flutter/widgets.dart';

class CartModel with ChangeNotifier {
  final String cardId;
  final String productId;
  final int quantity;

  CartModel({
    required this.cardId,
    required this.productId,
    required this.quantity,
  });
}
