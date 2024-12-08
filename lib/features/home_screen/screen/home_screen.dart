import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/features/home_screen/providers/category_provider.dart';
import 'package:semb_assignment/features/home_screen/providers/products_provider.dart';
import 'package:semb_assignment/features/favorite_screen/screen/favorites_screen.dart';
import 'package:semb_assignment/core/utils/string_utils.dart';
import 'package:semb_assignment/features/home_screen/widgets/app_search_bar.dart';
import 'package:semb_assignment/core/widgets/products_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _ProductsGridScreenState();
}

class _ProductsGridScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;
  String selectedCategory = 'All';

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categorories = ref.watch(categoryProvider);
    var searchAppBar = SliverAppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color.fromARGB(255, 241, 205, 95),
        pinned: true,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: AppSearchBar(),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                icon: Icon(Icons.category, size: 22.sp, color: Colors.white),
                onSelected: (String selected) {
                  setState(() {
                    selectedCategory = selected;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return categorories
                      .map((e) => PopupMenuItem<String>(
                            value: e,
                            child: Text(StringUtils.capitalizeEachWord(e)),
                          ))
                      .toList();
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesScreen()));
                },
                icon: const Icon(Icons.favorite),
                iconSize: 24.sp,
                color: Colors.white,
              ),
            ],
          ),
        ));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 205, 95),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            backgroundColor: const Color.fromARGB(255, 241, 205, 95),
            expandedHeight: 9.h,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Products From",
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.sp,
                    ),
                    child: const Text(
                      "SembAI",
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              return ref.refresh(productsProvider);
            },
          ),
          ...ref.watch(productsProvider).when(
            data: (data) {
              final filteredProduct = selectedCategory != "All"
                  ? data
                      .where((element) => element.category == selectedCategory)
                      .toList()
                  : data;

              return [
                searchAppBar,
                ProductsGridView(products: filteredProduct)
              ];
            },
            error: (error, stackTrace) {
              return [
                SliverFillRemaining(
                    child: Center(child: Text(error.toString())))
              ];
            },
            loading: () {
              return [
                SliverFillRemaining(
                    child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.white, size: 40),
                ))
              ];
            },
          )
        ],
      ),
    );
  }
}
