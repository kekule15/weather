import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/app_helpers.dart';
import 'package:weather/utils/svgs.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/shimmer_widget.dart';
import 'package:weather/widgets/single_text_line_widget.dart';
import 'package:weather/widgets/weather_info_widget.dart';

class UserCurrentLocationWeatherView extends ConsumerWidget {
  const UserCurrentLocationWeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(weatherDataProvider);
    final themeDataMode = ref.watch(themeDataProvider);
    return Container(
      height: 570.h,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: SingleTextLineWidget(
                text: 'My Location ',
                size: 15.sp,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            switch (viewmodel.isLoadingCoordinate) {
              true => const MyLocationMainShimmer(),
              false => Container(
                  height: 300.h,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: AppColors.gray.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SingleTextLineWidget(
                            text:
                                '${viewmodel.myLocationData?.name.toString()}, ${viewmodel.myLocationData?.sys?.country.toString()}',
                            size: 15.sp,
                            weight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SvgImage(
                            asset: AppHelpers.getWeatherImage(
                                group: viewmodel
                                    .myLocationData?.weather?.first.id),
                            width: 100.w,
                            height: 100.w,
                            color: switch (themeDataMode.isdarkTheme!) {
                              true => AppColors.white,
                              false => null
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        SingleTextLineWidget(
                          text: AppHelpers.convertNamedDateDisplay(
                              DateTime.now().toString()),
                          size: 15.sp,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SingleTextLineWidget(
                          text:
                              "${viewmodel.myLocationData?.main?.tempMax.toString()}\u00B0",
                          size: 45.sp,
                          weight: FontWeight.bold,
                        ),
                         SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleTextLineWidget(
                              text:
                                  "${viewmodel.myLocationData?.weather?.first.main.toString()}",
                              size: 15.sp,
                            ),
                            SizedBox(
                              width: 4.h,
                            ),
                            SingleTextLineWidget(
                              text: " | ",
                              size: 17.sp,
                            ),
                            SizedBox(
                              width: 4.h,
                            ),
                            SingleTextLineWidget(
                              text:
                                  "${viewmodel.myLocationData?.weather?.first.description.toString()}",
                              size: 15.sp,
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SvgImage(
                        //       asset: rainIconSVG,
                        //       width: 100.w,
                        //       height: 100.w,
                        //       color: AppColors.white,
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SingleTextLineWidget(
                        //           text: AppHelpers.convertNamedDateDisplay(
                        //               DateTime.now().toString()),
                        //           size: 15.sp,
                        //           color: AppColors.white,
                        //         ),
                        //         SingleTextLineWidget(
                        //     text: "24\u00B0",
                        //     size: 50.sp,
                        //     color: AppColors.white,
                        //   ),
                        //       ],
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
            },
            SizedBox(
              height: 20.h,
            ),
            switch (viewmodel.isLoadingCoordinate) {
              true => const MyLocationMiniShimmer(),
              false => Container(
                  height: 150.h,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: AppColors.gray.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: WeatherInfoWidget(
                                  image: temperatureIconSVG,
                                  title: "Temperature",
                                  value:
                                      "${viewmodel.myLocationData?.main?.temp}\u00B0"),
                            ),
                            Expanded(
                              child: WeatherInfoWidget(
                                  image: pressureIconSVG,
                                  title: "Pressure",
                                  value:
                                      "${viewmodel.myLocationData?.main?.pressure}psi"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: WeatherInfoWidget(
                                  image: windIconSVG,
                                  title: "Wind",
                                  value:
                                      "${viewmodel.myLocationData?.wind?.deg}mph"),
                            ),
                            Expanded(
                              child: WeatherInfoWidget(
                                  image: humidityIconSVG,
                                  title: "Humidity",
                                  value:
                                      "${viewmodel.myLocationData?.main?.humidity}%"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
            },
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
