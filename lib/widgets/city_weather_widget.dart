import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/model/city_data_model.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/widgets/menu_bar_widget.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class CityWeatherWidget extends ConsumerWidget {
  final CityDataModel data;
  final bool selected;
  final VoidCallback onTap;
  const CityWeatherWidget(
      {required this.data,
      required this.selected,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewmodel = ref.watch(weatherDataProvider);
    final List caseDetailsOptions = [
      "Remove City",
    ];
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color:
              selected ? AppColors.themeGreen : AppColors.gray.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleTextLineWidget(
                text: data.name,
                size: 15.sp,
                weight: FontWeight.w600,
                color: selected ? AppColors.white : AppColors.black,
              ),
              SizedBox(
                width: 20.w,
                height: 15.w,
                child: CustomPopMenuBarWidget(
                  icon: Icon(
                    Icons.more_vert,
                    size: 15.w,
                    color: selected ? AppColors.white : AppColors.black,
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case "Remove City":
                        viewmodel.removeCityFromStoredList(
                              name: data.name, next: () {});
                    }
                  },
                  item: List.generate(
                    caseDetailsOptions.length,
                    (index) => PopupMenuItem<String>(
                      value: caseDetailsOptions[index],
                      child: InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              caseDetailsOptions[index],
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
