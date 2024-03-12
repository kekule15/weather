import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/style/appColors.dart';

class TextShimmerWidget extends StatelessWidget {
  const TextShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(0.2),
      highlightColor: AppColors.gray4.withOpacity(0.4),
      child: Container(
        height: 7.h,
        width: 35.w,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class ImageShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ImageShimmerWidget({this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(0.2),
      highlightColor: AppColors.gray4.withOpacity(0.4),
      child: Container(
        height: height ?? 70.w,
        width: width ?? 70.w,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
