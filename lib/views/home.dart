import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/user_location_provider.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/views/city_list.dart';
import 'package:weather/views/drawer.dart';
import 'package:weather/views/user_current_location_weather.dart';
import 'package:weather/widgets/city_card_widget.dart';
import 'package:weather/widgets/city_weather_widget.dart';
import 'package:weather/widgets/shimmer_widget.dart';
import 'package:weather/widgets/single_text_line_widget.dart';
import 'package:weather/widgets/week_card_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    void openMyDrawer() {
      scaffoldKey.currentState!.openDrawer();
    }

    var viewmodel = ref.watch(weatherDataProvider);
    var locationViewModel = ref.watch(userLocationViewModelProvider);
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawerPage(),
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
                      onTap: () {
                        openMyDrawer();
                      },
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
                    InkWell(
                      onTap: () {
                        viewmodel.getCityWeatherData(
                            city: viewmodel.selectedCity.name);
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 20.w,
                      ),
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
                            backgroundColor:
                                Theme.of(context).dialogBackgroundColor,
                            context: context,
                            isDismissible: true,
                            showDragHandle: false,
                            isScrollControlled: true,
                            enableDrag: false,
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
                            padding: EdgeInsets.only(left: 15.w),
                            child: CityWeatherWidget(
                              onTap: () {
                                viewmodel.selectCity(city: data);
                              },
                              data: data,
                              selected:
                                  viewmodel.selectedCity.name == data.name,
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
              const CityCardWidget(),
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
          switch (viewmodel.isLoadingWeather) {
            true => Padding(
                padding: EdgeInsets.only(
                    top: 350.h,
                    left: generalHorizontalPadding,
                    right: generalHorizontalPadding),
                child: const LoadWeekShimmer(),
              ),
            false => Padding(
                padding: EdgeInsets.only(
                    top: 350.h,
                    left: generalHorizontalPadding,
                    right: generalHorizontalPadding),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: viewmodel.list?.length,
                    itemBuilder: (context, index) {
                      var cityData = viewmodel.list?[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: WeekCardWidget(
                            date: cityData?.dt,
                            description: cityData?.weather![0].description,
                            min: cityData?.temp!.min.toString(),
                            max: cityData?.temp!.max.toString(),
                            group: cityData?.weather![0].id),
                      );
                    }))
          }
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await locationViewModel.getLocation();

          showModalBottomSheet(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            context: context,
            isDismissible: true,
            showDragHandle: false,
            isScrollControlled: true,
            enableDrag: false,
            builder: (BuildContext context) {
              return const UserCurrentLocationWeatherView();
            },
          );
          await viewmodel.getWeatherByCoordinate();
        },
        child: const Icon(
          Icons.location_on,
          color: AppColors.white,
        ),
      ),
    );
  }
}
