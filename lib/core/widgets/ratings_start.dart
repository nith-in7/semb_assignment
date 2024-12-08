import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RatingsStart extends StatelessWidget {
  const RatingsStart(
      {super.key,
      required this.rating,
      this.size = 16,
      this.color = Colors.grey,
      this.mainAxisAlignment = MainAxisAlignment.start});
  final double rating;
  final double size;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(5, (index) {
        return Icon(
          (index < rating.floor())
              ? Icons.star
              : (index < rating)
                  ? Icons.star_half
                  : Icons.star_border,
          color: color,
          size: size.sp,
        );
      }),
    );
  }
}
