import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/utils/images.dart';
import 'package:weather/utils/svgs.dart';
import 'package:weather/views/city_list.dart';
import 'package:weather/widgets/image_widgets.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Container(
                height: 140.h,
                width: MediaQuery.sizeOf(context).width / 1.2,
                margin: const EdgeInsets.only(left: generalHorizontalPadding),
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
              ),
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
                top: 300.h,
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
