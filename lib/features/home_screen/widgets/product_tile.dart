import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/core/models/product_model.dart';
import 'package:semb_assignment/features/product_screen/screen/product_screen.dart';
import 'package:semb_assignment/core/utils/string_utils.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, required this.onTap});
  final ProductModel product;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(productModel: product)));
      },
      leading: CachedNetworkImage(
        imageUrl: product.image,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
      title: Text(
        product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(StringUtils.capitalizeEachWord(product.category)),
      trailing: Text(
        "₹ ${product.price}",
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }
}
