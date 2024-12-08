import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:semb_assignment/features/home_screen/providers/category_provider.dart';
import 'package:semb_assignment/core/utils/hive_controllers.dart';
part 'products_provider.g.dart';

@Riverpod(keepAlive: true)
class Products extends _$Products {
  final _productBox = Hive.box<ProductModel>(HiveControllers.productsBoxName);
  @override
  FutureOr<List<ProductModel>> build() {
    return fetchProductData();
  }

  Future<List<ProductModel>> fetchProductData() async {
    final url = Uri.parse("https://fakestoreapi.com/products");

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) throw "Failed to load products";
      final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));

      final Set<String> categories = {};
      final List<ProductModel> productList = [];
      _productBox.clear();
      for (Map<String, dynamic> element in body) {
        final product = ProductModel.fromMap(element);
        categories.add(product.category);
        _productBox.put(product.id, product);
        productList.add(product);
      }

      ref.read(categoryProvider.notifier).addCategory([...categories]);

      return productList;
    } catch (e) {
      return getProductsFromLocal();
    }
  }

  List<ProductModel> getProductsFromLocal() {
    final List<ProductModel> product = [];
    for (var i = 0; i < _productBox.length; i++) {
      final prod = _productBox.getAt(i);
      if (prod != null) {
        product.add(prod);
      }
    }
    return product;
  }
}
