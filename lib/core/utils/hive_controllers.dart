import 'package:hive_flutter/hive_flutter.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/core/models/rating_model.dart';

class HiveControllers {
  static String productsBoxName = "ProductsBox";
  static String favoriteBoxName = "FavoriteBox";

  static Future<void> registerHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(RatingModelAdapter());
    await Hive.openBox<ProductModel>(productsBoxName);
    await Hive.openBox<ProductModel>(favoriteBoxName);
  }
}
