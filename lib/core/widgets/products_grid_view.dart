import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/features/product_screen/screen/product_screen.dart';
import 'package:semb_assignment/core/widgets/product_card.dart';

class ProductsGridView extends ConsumerStatefulWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    this.disableAnimation = false,
  });
  final List<ProductModel> products;
  final bool disableAnimation;

  @override
  ConsumerState<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends ConsumerState<ProductsGridView> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(15.sp),
      sliver: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15.sp,
              mainAxisSpacing: 15.sp,
              crossAxisCount: 2,
              childAspectRatio: .65),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            if (widget.disableAnimation) {
              return ProductCard(productModel: widget.products[index]);
            }
            return OpenContainer(
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              useRootNavigator: true,
              closedBuilder: (context, action) => ProductCard(
                  productModel: widget.products[index], onTap: action),
              openBuilder: (context, action) => ProductScreen(
                  productModel: widget.products[index], onTap: action),
            );
          }),
    );
  }
}
