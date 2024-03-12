import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class WeekCardShimmerWidget extends StatelessWidget {
  const WeekCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.gray.withOpacity(0.3)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageShimmerWidget(
              width: 30.w,
              height: 10.h,
            ),
            ImageShimmerWidget(
              width: 30.w,
              height: 30.w,
            ),
            ImageShimmerWidget(
              width: 50.w,
              height: 20.h,
            ),
            ImageShimmerWidget(
              width: 70.w,
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadWeekShimmer extends ConsumerWidget {
  const LoadWeekShimmer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: 3,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: const WeekCardShimmerWidget(),
          );
        });
  }
}
