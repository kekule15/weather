import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleTextLineWidget extends ConsumerWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final double? height;
  const SingleTextLineWidget(
      {required this.text,
      this.size,
      this.weight,
      this.color,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.headlineMedium!.copyWith(
          fontSize: size ?? 12.sp,
          fontWeight: weight ?? FontWeight.w400,
          height: height ??
              Theme.of(context).primaryTextTheme.headlineMedium!.height,
          color: color ??
              Theme.of(context)
                  .primaryTextTheme
                  .headlineMedium!
                  .color!
                  .withOpacity(0.7)),
    );
  }
}
