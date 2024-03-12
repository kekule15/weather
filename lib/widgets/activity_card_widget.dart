import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/style/appColors.dart';

class ActivityCardWidget extends ConsumerWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool? isTrailingTrue;
  bool? swicthValue;
  final bool? showLeadingBg;
  final Widget? icon;
  final bool? isSwitchBtn;
  final Widget? trailingIcon;
  final bool? isShadow;
  ActivityCardWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isTrailingTrue,
      required this.swicthValue,
      this.showLeadingBg,
      required this.icon,
      this.isSwitchBtn,
      this.isShadow,
      this.trailingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: isShadow == true
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: Theme.of(context).cardTheme.color,
              boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    offset: const Offset(2, 2),
                    spreadRadius: 4,
                    blurRadius: 10,
                  )
                ])
          : const BoxDecoration(),
      child: ListTile(
        onTap: onTap,
        leading: Container(
            height: 25.w,
            width: 25.w,
            decoration: BoxDecoration(
                color: showLeadingBg == false
                    ? Colors.transparent
                    : AppColors.gray.withOpacity(0.4),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: icon,
            )),
        title: Text(title!,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp)),
        trailing: isTrailingTrue != true
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : isSwitchBtn == false
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: trailingIcon,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 0, bottom: 0),
                    child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        activeColor: AppColors.primary,
                        value: swicthValue!,
                        onChanged: (val) {
                          onTap!();
                          swicthValue = !swicthValue!;
                        },
                      ),
                    )),
      ),
    );
  }
}

class ActivityCardWithSubTitle extends ConsumerWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isTrailingTrue;
  final bool isLeadingTrue;
  final Widget? leading;
  final Widget? icon;
  final bool reverse;
  final Color? titleColor;
  final bool? isShadow;
  const ActivityCardWithSubTitle(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      required this.isTrailingTrue,
      required this.isLeadingTrue,
      this.leading,
      this.icon,
      this.titleColor,
      this.isShadow,
      required this.reverse})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeDataMode = ref.watch(themeDataProvider);
    return Container(
      decoration: isShadow == true
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: Theme.of(context).cardTheme.color,
              boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    offset: const Offset(2, 2),
                    spreadRadius: 4,
                    blurRadius: 10,
                  )
                ])
          : const BoxDecoration(),
      child: ListTile(
        minVerticalPadding: 6,
        onTap: onTap,
        minLeadingWidth: isLeadingTrue == true ? 20 : 0,
        leading: isLeadingTrue == true
            ? Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                    color: isLeadingTrue == false
                        ? Colors.transparent
                        : AppColors.gray.withOpacity(0.4),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: leading,
                ))
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        title: Text(
          title,
          style: Theme.of(context).primaryTextTheme.headlineMedium!.copyWith(
              fontWeight: reverse == true ? FontWeight.w500 : FontWeight.w300,
              color: titleColor ??
                  (themeDataMode.isdarkTheme == true
                      ? AppColors.white
                      : AppColors.black),
              fontSize: reverse == true ? 15 : 12),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).primaryTextTheme.headlineMedium!.copyWith(
              height: reverse == true ? 1 : 2,
              fontWeight: reverse == true ? FontWeight.w300 : FontWeight.w500,
              fontSize: reverse == true ? 12 : 15),
        ),
        trailing: isTrailingTrue == true
            ? icon
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }
}

class ActionListTileCard extends ConsumerWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool? isTrailingTrue;
  final Widget? trailingIcon;
  const ActionListTileCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isTrailingTrue,
      this.trailingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      // contentPadding: EdgeInsets.all(0),
      onTap: onTap,
      title: Text(title!,
          textAlign: TextAlign.start,
          style: Theme.of(context).primaryTextTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w500, height: 0.8, fontSize: 11.sp)),
      trailing: isTrailingTrue != true
          ? const SizedBox(
              height: 0,
              width: 0,
            )
          : Padding(
              padding: const EdgeInsets.only(top: 4),
              child: trailingIcon,
            ),
    );
  }
}
