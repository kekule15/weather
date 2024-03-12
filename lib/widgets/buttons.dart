
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/style/appColors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.actionText,
      this.style,
      this.color,
      this.fillColor,
      this.radius,
      this.width,
      this.widget,
      this.height,
      this.disabled = false,
      this.disabledColor,
      this.outLineColor,
      this.isOutline = false,
      required this.onTap})
      : super(key: key);
  final String actionText;
  final Color? color;
  final Color? fillColor;
  final Color? outLineColor;
  final bool isOutline;
  final bool disabled;
  final Widget? widget;
  final Color? disabledColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final double? radius;

  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          HapticFeedback.heavyImpact();
          onTap!();
        }
      },
      child: Container(
          width: width ?? double.infinity,
          height: height ?? 48,
          decoration: BoxDecoration(
              color: disabled
                  ? disabledColor ??
                      Theme.of(context).canvasColor.withOpacity(0.5)
                  : (isOutline
                      ? Colors.transparent
                      : fillColor ?? Theme.of(context).canvasColor),
              border: isOutline
                  ? Border.all(
                      color: outLineColor ??
                          color ??
                          Theme.of(context).canvasColor.withOpacity(.9))
                  : null,
              borderRadius: BorderRadius.circular(radius ?? 8)),
          alignment: Alignment.center,
          child: widget ??
              Text(
                actionText,
                style: style ??
                    Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                        color: isOutline
                            ? color ??
                                Theme.of(context).canvasColor.withOpacity(.9)
                            : null),
              )),
    );
  }
}

class WordsButton extends StatelessWidget {
  const WordsButton(
      {Key? key,
      required this.onTap,
      required this.firstText,
      required this.secondText,
      this.textAlign,
      this.firstTextColor,
      this.secondTextColor,
      this.firstTextSize,
      this.secondTextSize,
      this.textHeight,
      this.underline = TextDecoration.none,
      this.underline3 = TextDecoration.none,
      this.disabled = false,
      this.fontWeight3,
      this.thirdText,
      this.thirdTextColor,
      this.thirdTextSize,
      this.fontWeight2})
      : super(key: key);

  final Function() onTap;
  final TextAlign? textAlign;
  final TextDecoration underline;
  final TextDecoration underline3;
  final String firstText;
  final double? textHeight;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final bool disabled;
  final double? firstTextSize;
  final double? secondTextSize;
  final String secondText;
  final String? thirdText;
  final double? thirdTextSize;
  final FontWeight? fontWeight3;
  final Color? thirdTextColor;
  final FontWeight? fontWeight2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      //textScaleFactor: MediaQuery.of(context).textScaleFactor,
      text: TextSpan(
        text: firstText,
        style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
              fontSize: firstTextSize ?? 13.sp,
              color: firstTextColor ??
                  Theme.of(context).primaryTextTheme.headlineMedium?.color,
              height: textHeight,
            ),
        children: <TextSpan>[
          TextSpan(
            text: '  ',
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          TextSpan(
            text: secondText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                  decoration: underline,
                  fontWeight: fontWeight2 ?? FontWeight.w400,
                  fontSize: secondTextSize ?? 14.sp,
                  color: secondTextColor ??
                      Theme.of(context).primaryTextTheme.headlineMedium?.color,
                  height: textHeight,
                ),
          ),
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
              text: thirdText,
              style:
                  Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                        decoration: underline3,
                        fontWeight: fontWeight3 ?? FontWeight.w400,
                        height: textHeight,
                        fontSize: thirdTextSize ?? 13.sp,
                        color: thirdTextColor ??
                            Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium
                                ?.color,
                      )),
        ],
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.actionText,
      required this.style,
      required this.onTap})
      : super(key: key);
  final String actionText;
  final TextStyle style;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(actionText, style: style),
    );
  }
}

class StatusTextButton extends StatelessWidget {
  const StatusTextButton(
      {Key? key,
      required this.actionText,
      this.onTap,
      this.bgColor,
      this.textSize,
      this.vertPadding,
      this.horipadding,
      this.radius,
      this.isBorder = true,
      this.borderColor,
      this.textFontWeight,
      this.textColor})
      : super(key: key);
  final String actionText;
  final Function? onTap;
  final Color? textColor;
  final double? textSize;
  final double? vertPadding;
  final double? horipadding;
  final Color? bgColor;
  final Color? borderColor;
  final double? radius;
  final bool isBorder;
  final FontWeight? textFontWeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        // width: 100.w,
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(radius ?? 5.r),
            border: isBorder
                ? Border.all(
                    color: borderColor ??
                        AppColors.termsTextColor.withOpacity(0.4))
                : null),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horipadding ?? 10.w, vertical: vertPadding ?? 10.h),
          child: Text(
            actionText,
            style: Theme.of(context).primaryTextTheme.headlineMedium!.copyWith(
                fontSize: textSize ?? 13.sp,
                fontWeight: textFontWeight ?? FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool? swapPosition;
  final VoidCallback onTap;
  final bool showBorder;
  final double? iconSize;
  final double? textSize;
  final Color? textColor;
  final Color? iconColor;
  final double? borderRadiuss;
  final double? itemSpace;

  const IconTextButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.showBorder = false,
      this.iconColor,
      this.iconSize,
      this.textColor,
      this.textSize,
      this.borderRadiuss,
      this.itemSpace,
      this.swapPosition = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: swapPosition == true
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: iconColor ?? AppColors.primary,
                    size: iconSize ?? 15,
                  ),
                  SizedBox(
                    width: itemSpace ?? 0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: textSize ?? 12,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? AppColors.black),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: textSize ?? 12,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? AppColors.black),
                  ),
                  SizedBox(
                    width: itemSpace ?? 0,
                  ),
                  Icon(
                    icon,
                    color: iconColor ?? AppColors.primary,
                    size: iconSize ?? 15,
                  ),
                ],
              ),
            ),
    );
  }
}

class SwitchTextButton extends ConsumerWidget {
  final String title;
  final Color? titleColor;
  final bool value;
  final VoidCallback onTap;
  const SwitchTextButton(
      {required this.title,
      this.titleColor,
      required this.value,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: titleColor ??
                    Theme.of(context).primaryTextTheme.headlineMedium?.color),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: AppColors.primary,
              value: value,
              onChanged: (val) => onTap(),
            ),
          )
        ],
      ),
    );
  }
}


class ActionCustomButton extends StatelessWidget {
  final String title;
  final Function onclick;
  final Color? btnColor;
  final Color? titleColor;
  final bool? borderColor;
  final Color? loadingColor;
  final bool isLoading;
  final bool? disabeled;
  final double? shadow;

  const ActionCustomButton(
      {Key? key,
      required this.title,
      required this.onclick,
      this.btnColor,
      this.titleColor,
      this.borderColor,
      this.loadingColor,
      this.disabeled = false,
      this.shadow,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabeled!
          ? null
          : () {
              FocusScope.of(context).unfocus();
              onclick();
            },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 47.h,
        child: Card(
          elevation: shadow ?? 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
          color: disabeled!
              ? btnColor?.withOpacity(0.2) ?? AppColors.themeGreen.withOpacity(0.2)
              : btnColor ?? AppColors.themeGreen,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: loadingColor ?? AppColors.white,
                    ),
                  )
                : Text(
                    title,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineMedium
                        ?.copyWith(
                            color: titleColor ?? AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                  ),
          ),
        ),
      ),
    );
  }
}
