
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/style/appColors.dart';

class NotifyMe {
  static showAlert(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showScaffoldAlert(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
      child: Text(message,
          style: Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
              fontSize: 13.sp,
              color: Theme.of(context).scaffoldBackgroundColor)),
    )));
  }


 
}
