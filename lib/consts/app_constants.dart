import 'package:shopsmart/models/categories_model.dart';
import 'package:shopsmart/services/assets_manager.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: AssetsManager.mobiles,
      image: AssetsManager.mobiles,
      name: 'Phones',
    ),
    CategoryModel(
      id: AssetsManager.pc,
      image: AssetsManager.pc,
      name: 'Laptops',
    ),
    CategoryModel(
      id: AssetsManager.electronics,
      image: AssetsManager.electronics,
      name: 'Electronics',
    ),
    CategoryModel(
      id: AssetsManager.shoes,
      image: AssetsManager.shoes,
      name: 'Shoes',
    ),
    CategoryModel(
      id: AssetsManager.watch,
      image: AssetsManager.watch,
      name: 'Watches',
    ),
    CategoryModel(
      id: AssetsManager.cosmetics,
      image: AssetsManager.cosmetics,
      name: 'Cosmetics',
    ),
    CategoryModel(
      id: AssetsManager.book,
      image: AssetsManager.book,
      name: 'Book',
    ),
    CategoryModel(
      id: AssetsManager.fashion,
      image: AssetsManager.fashion,
      name: 'Clothes',
    ),
  ];
}
