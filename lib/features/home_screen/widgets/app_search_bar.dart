import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/features/home_screen/providers/products_provider.dart';
import 'package:semb_assignment/features/home_screen/widgets/product_tile.dart';

class AppSearchBar extends ConsumerWidget {
  const AppSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider).maybeWhen(
          data: (data) => data.map((product) => product).toList(),
          orElse: () => <ProductModel>[],
        );
    return SearchAnchor(
        viewBackgroundColor: Colors.white,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            shape: WidgetStatePropertyAll<OutlinedBorder?>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            backgroundColor: const WidgetStatePropertyAll<Color?>(Colors.white),
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          final searchedProduct = products
              .where((element) =>
                  element.title.toLowerCase().contains(controller.text))
              .toList();
          return searchedProduct.isEmpty
              ? [const ListTile(title: Text('No results found'))]
              : searchedProduct.map((product) {
                  return ProductTile(
                      product: product,
                      onTap: () {
                        controller.clear();
                        controller.closeView(null);
                      });
                }).toList();
        });
  }
}
