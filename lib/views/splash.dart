import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/style/appColors.dart';
import 'package:weather/utils/images.dart';
import 'package:weather/utils/router.dart';
import 'package:weather/utils/svgs.dart';
import 'package:weather/widgets/image_widgets.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Animation? time;

  @override
  void didChangeDependencies() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    time = Tween(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          context.pushReplacement(AppRouter.homeRoute);
        }
      }));

    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool _visible = true;

    return Scaffold(
        backgroundColor: AppColors.themeGreen,
        body: Center(
            child: SvgImage(
          asset: sunIconSVG,
          width: 100.w,
          height: 100.w,
          color: AppColors.white,
        )));
  }
}
