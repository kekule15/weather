import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/model/city_data_model.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class CityWeatherWidget extends ConsumerWidget {
  final CityDataModel data;
  final bool selected;
  final VoidCallback onTap;
  const CityWeatherWidget(
      {required this.data, required this.selected,required this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: ()=> onTap() ,
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
                weight: FontWeight.bold,
                color: selected ? AppColors.white : AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
