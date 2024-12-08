import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/features/favorite_screen/providers/favorites_provider.dart';
import 'package:semb_assignment/core/widgets/ratings_start.dart';
import 'package:semb_assignment/core/models/product_model.dart';

class ProductTop extends ConsumerStatefulWidget {
  const ProductTop({
    super.key,
    required this.productModel,
    this.onTap,
  });
  final ProductModel productModel;
  final void Function({Never returnValue})? onTap;

  @override
  ConsumerState<ProductTop> createState() => _ProductTopState();
}

class _ProductTopState extends ConsumerState<ProductTop> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = ref
        .watch(favoritesProvider)
        .any((element) => element.id == widget.productModel.id);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 249, 242, 221)),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12.sp),
                child: CachedNetworkImage(
                  height: 40.h,
                  fit: BoxFit.contain,
                  imageUrl: widget.productModel.image,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Row(
                  children: [
                    IconButton.filled(
                        style:
                            IconButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: widget.onTap ??
                            () {
                              Navigator.pop(context);
                            },
                        icon: const Icon(Icons.arrow_back)),
                    const Spacer(),
                    IconButton.filled(
                        isSelected: isFavorite,
                        style:
                            IconButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: () {
                          if (isFavorite) {
                            ref
                                .read(favoritesProvider.notifier)
                                .deleteProduct(widget.productModel.id);
                          } else {
                            ref
                                .read(favoritesProvider.notifier)
                                .addProduct(widget.productModel);
                          }
                        },
                        selectedIcon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingsStart(
                  rating: widget.productModel.rating.rate,
                  color: Colors.black,
                  size: 17,
                ),
                SizedBox(
                  width: 6.sp,
                ),
                Text(
                  "${widget.productModel.rating.count}",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
