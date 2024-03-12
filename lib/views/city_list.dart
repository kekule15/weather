import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/model/city_data_model.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/notify_me.dart';
import 'package:weather/widgets/customfield.dart';
import 'package:weather/widgets/menu_bar_widget.dart';
import 'package:weather/widgets/single_text_line_widget.dart';

class CityListView extends ConsumerStatefulWidget {
  const CityListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CityListViewState();
}

class _CityListViewState extends ConsumerState<CityListView> {
  final searchTextController = TextEditingController();
  List<CityDataModel> seachedCityData = [];
  @override
  Widget build(BuildContext context) {
    var viewmodel = ref.watch(weatherDataProvider);

    var cityDataList = viewmodel.cityDataList;

    // THE CUSTOME WIDGET THAT DISPLAYS LIST OF CITIES EITHER FROM THE SEARCHED DATA OR FROM THE MAIN DATA SOUTCE
    Widget businessTypeListWidget(int index, List<CityDataModel> myList) {
      final List caseDetailsOptions = [
        "Add City to Carousel",
        "View City Weather"
      ];
      var value = myList[index];
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: CustomPopMenuBarWidget(
          icon: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Theme.of(context).cardTheme.color,
            ),
            child: SingleTextLineWidget(
              text: value.name.toString(),
              size: 14.sp,
              weight: FontWeight.w500,
            ),
          ),
          onSelected: (values) {
            switch (values) {
              case "Add City to Carousel":
                if (viewmodel.storedCityList
                    .any((element) => element.name.contains(value.name))) {
                  NotifyMe.showAlert("City already added");
                } else {
                  viewmodel.addCityToList(
                      item: value,
                      next: () {
                        context.pop();
                      });
                }
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
      );
    }

    // THE METHOD THAT SORTS OR FILTERES CITY LIST BASED ON THE SEARCH INPUT:
    // BELOW ARE THE SEARCH INPUT PARAMETERS YOU CAN FILTER WITH...
    // [ NAME, ETC ]
    List<CityDataModel> buildSearchList(String userSearchTerm) {
      List<CityDataModel> searchList = [];
      for (int i = 0; i < cityDataList.length; i++) {
        String categoryName = cityDataList[i].name;

        if (categoryName.toLowerCase().contains(userSearchTerm.toLowerCase())) {
          setState(() {
            searchList.add(cityDataList[i]);
          });
        } else {
          // return searchList;
        }
      }
      return searchList;
    }

    return Container(
      height: 400.h,
      width: MediaQuery.sizeOf(context).width,
      // padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: CustomField(
                headtext: "Search city name",
                controller: searchTextController,
                //fillColor: Theme.of(context).cardColor,
                pIcon: Icon(
                  Icons.search,
                  size: 13.w,
                ),
                onChanged: (val) {
                  setState(() {
                    seachedCityData = buildSearchList(val);
                  });
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SingleTextLineWidget(
              text: 'Select city ',
              size: 12.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            switch (cityDataList.isEmpty) {
              true => const Center(child: Text("No Item found")),
              false => Column(
                  children: List.generate(
                      (seachedCityData != [] && seachedCityData.isNotEmpty)
                          ? seachedCityData.length
                          : cityDataList.length,
                      (index) =>
                          (seachedCityData != [] && seachedCityData.isNotEmpty)
                              ? businessTypeListWidget(index, seachedCityData)
                              : businessTypeListWidget(index, cityDataList)),
                )
            }
          ],
        ),
      ),
    );
  }
}
