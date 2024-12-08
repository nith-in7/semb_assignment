import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/core/utils/string_utils.dart';
import 'package:semb_assignment/core/widgets/ratings_start.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/features/product_screen/screen/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel, this.onTap});
  final ProductModel productModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductScreen(productModel: productModel),
                ));
          },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 247, 245, 238)),
          color: const Color.fromARGB(255, 249, 233, 181),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.sp),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 55.sp,
              width: 100.w,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: productModel.image,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingsStart(rating: productModel.rating.rate),
                  Text(
                    StringUtils.capitalizeEachWord(productModel.category),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.sp),
                  Text(
                    productModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 6.sp),
                  Text(
                    "₹ ${productModel.price}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
