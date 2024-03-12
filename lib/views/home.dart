import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/utils/svgs.dart';
import 'package:weather/views/city_list.dart';
import 'package:weather/widgets/city_card_widget.dart';
import 'package:weather/widgets/city_weather_widget.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(weatherDataProvider);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: generalHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.menu,
                        size: 20.w,
                      ),
                    ),
                    SingleTextLineWidget(
                      text: "Weather",
                      size: 18.sp,
                      weight: FontWeight.bold,
                    ),
                    Icon(
                      Icons.refresh,
                      size: 20.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isDismissible: false,
                            showDragHandle: true,
                            isScrollControlled: true,
                            enableDrag: true,
                            builder: (BuildContext context) {
                              return const CityListView();
                            },
                          );
                        },
                        child: Container(
                            height: 35.w,
                            width: 70.w,
                            margin: EdgeInsets.only(
                                left: generalHorizontalPadding, right: 5.w),
                            decoration: BoxDecoration(
                                color: AppColors.themeGreen,
                                borderRadius: BorderRadius.circular(7.r),
                                border:
                                    Border.all(color: AppColors.themeGreen)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 16.w,
                                    color: AppColors.white,
                                  ),
                                  SingleTextLineWidget(
                                    text: "Add City",
                                    size: 10.sp,
                                    weight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 30.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(viewmodel.storedCityList.length,
                            (index) {
                          var data = viewmodel.storedCityList[index];
                          return Padding(
                            padding:  EdgeInsets.only(left: 15.w),
                            child: CityWeatherWidget(
                              onTap: () {
                                viewmodel.selectCity(city: data);
                              },
                              data: data,
                              selected: viewmodel.selectedCity.name == data.name,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CityCardWidget(),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: generalHorizontalPadding),
                child: SingleTextLineWidget(
                  text: "This Week",
                  size: 15.sp,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 350.h,
                left: generalHorizontalPadding,
                right: generalHorizontalPadding),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
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
                          text: "Tue",
                          weight: FontWeight.bold,
                          size: 13.sp,
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        SvgImage(
                          asset: sunSetIconSVG,
                          width: 30.w,
                          height: 30.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleTextLineWidget(
                              text: "Moderate rain",
                              color: AppColors.white,
                              size: 9.sp,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Row(
                            children: [
                              SingleTextLineWidget(
                                text: "32\u00B0",
                                size: 9.sp,
                                weight: FontWeight.bold,
                              ),
                              SingleTextLineWidget(
                                text: "36\u00B0",
                                size: 9.sp,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
