import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/core/utils/hive_controllers.dart';
part 'favorites_provider.g.dart';

@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  static final _favBox =
      Hive.box<ProductModel>(HiveControllers.favoriteBoxName);
  @override
  List<ProductModel> build() {
    final List<ProductModel> fav = [];
    for (var i = 0; i < _favBox.length; i++) {
      final prod = _favBox.getAt(i);
      if (prod != null) fav.add(prod);
    }
    return fav;
  }

  void addProduct(ProductModel product) {
    state = [...state, product];
    _favBox.put(product.id, product);
  }

  void deleteProduct(int productId) {
    final index = state.indexWhere((element) => element.id == productId);
    final product = state.removeAt(index);
    state = [...state];
    _favBox.delete(product.id);
  }
}
