import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semb_assignment/features/favorite_screen/providers/favorites_provider.dart';
import 'package:semb_assignment/core/widgets/products_grid_view.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 205, 95),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Color.fromARGB(255, 241, 205, 95),
              pinned: true,
              elevation: 0,
              stretch: true,
              title: Text("Favorites")),
          ProductsGridView(products: favorites, disableAnimation: true)
        ],
      ),
    );
  }
}
