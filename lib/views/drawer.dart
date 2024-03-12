
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/widgets/activity_card_widget.dart';

class MyDrawerPage extends ConsumerStatefulWidget {
  const MyDrawerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerPageState();
}

class _MyDrawerPageState extends ConsumerState<MyDrawerPage> {

  @override
  Widget build(BuildContext context) {
    
    final themeDataMode = ref.watch(themeDataProvider);
    return SafeArea(
      bottom: false,
      child: Drawer(
        elevation: 10.w,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          width: 500.w,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 0.0, color: AppColors.gray))),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 100.h,
                child: DrawerHeader(
                  padding: EdgeInsets.fromLTRB(ySpace2, 0, 0, 15.h),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                  decoration: const BoxDecoration(
                    color: AppColors.termsTextColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70.w,
                        width: 70.w,
                        decoration:  const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.primary
                            
                            ),
                      ),
                      const SizedBox(
                        width: ySpace1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Augustus",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.white),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: ySpaceMin, bottom: ySpaceMin),
                            height: ySpaceMin - 4.5,
                            width: 50.h,
                            decoration: const BoxDecoration(
                              color: AppColors.gray,
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                            child: Text("Augustusonyekachi111@gmail.com",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
             
              ActivityCardWidget(
                title: 'Dark mode',
                onTap: () {
                  themeDataMode.toggleTheme();
                },
                isTrailingTrue: true,
                swicthValue: themeDataMode.isdarkTheme!,
                icon:  Icon(Icons.mode_night, size: 16.w,),
              ),
              divider(context),
             
           
            ],
          ),
        ),
      ),
    );
  }
}

divider(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: ySpaceMid + 2),
      height: ySpaceMin - 4.5,
      width:50.w,
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(0.3),
      ),
    ),
  );
}
