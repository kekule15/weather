import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/utils/svgs.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class CityCardWidget extends ConsumerWidget {
  const CityCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 140.h,
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
      decoration: BoxDecoration(
        color: AppColors.themeGreen,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleTextLineWidget(
                  text: "Lagos",
                  size: 15.sp,
                  weight: FontWeight.bold,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 6.h,
                ),
                SingleTextLineWidget(
                  text: "Tuesday, 12 March 2024",
                  size: 10.sp,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 15.h,
                ),
                SingleTextLineWidget(
                  text: "24\u00B0",
                  size: 35.sp,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 6.h,
                ),
                SingleTextLineWidget(
                  text: "Sunny",
                  size: 10.sp,
                  color: AppColors.white,
                ),
              ],
            ),
            SvgImage(
              asset: sunIconSVG,
              width: 80.w,
              height: 80.w,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
