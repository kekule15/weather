
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/utils/constvalues.dart';
import 'package:weather/widgets/image_widgets.dart';

class CustomLogoLoadingIndicator extends StatelessWidget {
  final double padding;
  const CustomLogoLoadingIndicator({Key? key, this.padding = ySpaceMid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: SpinKitPumpingHeart(
        size: 200,
        itemBuilder: (context, index) =>  ImageWidget(
          asset: "",
          width: 50.w,
          height: 50.w,
        ),
      ),
    ));
  }
}
