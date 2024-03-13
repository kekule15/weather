import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/app_helpers.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';
import 'package:weather/widgets/shimmer_widget.dart';

class CityCardWidget extends ConsumerWidget {
  const CityCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(weatherDataProvider);
    var cityData = viewmodel.list ?? [];

    return Container(
      height: 145.h,
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
                  text: viewmodel.selectedCity.name.toString(),
                  size: 15.sp,
                  weight: FontWeight.bold,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 6.h,
                ),
                SingleTextLineWidget(
                  text: AppHelpers.convertNamedDateDisplay(
                      DateTime.now().toString()),
                  size: 10.sp,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 15.h,
                ),
                switch (viewmodel.isLoadingWeather) {
                  true => ImageShimmerWidget(
                      width: 40.w,
                      height: 40.w,
                    ),
                  false => SingleTextLineWidget(
                      text: "${cityData.first.temp!.day.toString()}\u00B0",
                      size: 35.sp,
                      color: AppColors.white,
                    ),
                },
                SizedBox(
                  height: 6.h,
                ),
                switch (viewmodel.isLoadingWeather) {
                  true => const TextShimmerWidget(),
                  false => SingleTextLineWidget(
                      text: "${cityData.first.weather![0].main}",
                      size: 10.sp,
                      color: AppColors.white,
                    ),
                },
              ],
            ),
            switch (viewmodel.isLoadingWeather) {
              true => const ImageShimmerWidget(),
              false => SvgImage(
                  asset: AppHelpers.getWeatherImage(
                      group: cityData.first.weather![0].id),
                  width: 80.w,
                  height: 80.w,
                  color: AppColors.white,
                )
            },
          ],
        ),
      ),
    );
  }
}
