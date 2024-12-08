import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/core/utils/string_utils.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/features/product_screen/widgets/product_top.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({required this.productModel, super.key, this.onTap});
  final ProductModel productModel;
  final void Function({Never returnValue})? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 205, 95),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: ProductTop(
            onTap: widget.onTap,
            productModel: widget.productModel,
          )),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12.sp),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringUtils.capitalizeEachWord(
                        widget.productModel.category),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.productModel.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  Text(
                    "Description",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.productModel.description,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  Text(
                    "Price",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "₹ ${widget.productModel.price}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
