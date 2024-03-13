import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class WeatherInfoWidget extends ConsumerWidget {
  final String image;
  final String title;
  final String value;
  const WeatherInfoWidget(
      {required this.image,
      required this.title,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeDataMode = ref.watch(themeDataProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgImage(
            asset: image,
            width: 35.w,
            height: 35.w,
            color: switch (themeDataMode.isdarkTheme!) {
              true => AppColors.white,
              false => null
            }),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleTextLineWidget(
              text: value,
              size: 10.sp,
            ),
            SizedBox(
              height: 3.h,
            ),
            SingleTextLineWidget(
              text: title,
              size: 10.sp,
            ),
          ],
        )
      ],
    );
    // return ListTile(
    //   minLeadingWidth: 0,
    //   visualDensity: const VisualDensity(horizontal: -4, vertical: -0),
    //   contentPadding: EdgeInsets.zero,
    //   dense: true,
    //   leading: SvgImage(
    //       asset: image,
    //       width: 35.w,
    //       height: 35.w,
    //       color: switch (themeDataMode.isdarkTheme!) {
    //         true => AppColors.white,
    //         false => null
    //       }),
    //   title: SingleTextLineWidget(
    //     text: value,
    //     size: 10.sp,
    //   ),
    //   subtitle: SingleTextLineWidget(
    //     text: title,
    //     size: 10.sp,
    //   ),
    // );
  }
}
