import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/app_helpers.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';
import 'package:get/get.dart';

class WeekCardWidget extends ConsumerWidget {
  final int? date;
  final String? description;
  final String? min;
  final String? max;
  final int? group;
  const WeekCardWidget(
      {required this.date,
      required this.description,
      required this.min,
      required this.max,
      required this.group,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeDataMode = ref.watch(themeDataProvider);
    var datt = DateTime.fromMillisecondsSinceEpoch(date! * 1000);
    final DateFormat serverFormater = DateFormat('E, MMM d');
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
            SingleTextLineWidget(
              text: serverFormater.format(datt).toString().split(",")[0],
              weight: FontWeight.bold,
              size: 13.sp,
            ),
            // SizedBox(
            //   width: 10.w,
            // ),
            SvgImage(
              asset: AppHelpers.getWeatherImage(group: group),
              width: 30.w,
              height: 30.w,
              color: switch (themeDataMode.isdarkTheme!) {
                true => AppColors.white,
                false => null
              },
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleTextLineWidget(
                  text: description.toString().capitalizeFirst!,
                  color: AppColors.white,
                  size: 9.sp,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 80.w,
              child: Row(
                children: [
                  SingleTextLineWidget(
                    text: "$min\u00B0",
                    size: 9.sp,
                    weight: FontWeight.bold,
                  ),
                   SingleTextLineWidget(
                    text: "/",
                    size: 14.sp,
                    weight: FontWeight.bold,
                  ),
                  SingleTextLineWidget(
                    text: "$max\u00B0",
                    size: 9.sp,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
