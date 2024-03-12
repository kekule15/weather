// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:renewabletek/styles/appColors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// customAppBar({required String title, Color? bgcolor, Color? itemColor}) {
//   return AppBar(
//     elevation: 0,
//     backgroundColor: bgcolor ?? AppColors.white,
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: InkWell(
//       onTap: () {
//         Get.back();
//       },
//       child: Icon(
//         Icons.west,
//         color: itemColor ?? AppColors.black,
//       ),
//     ),
//     title: Text(
//       title,
//       style: TextStyle(
//           color: itemColor ?? AppColors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 16.sp),
//     ),
//   );
// }

// customAppBarWithOnTap({required String title, Color? bgcolor, Color? itemColor, VoidCallback? onTap}) {
//   return AppBar(
//     elevation: 0,
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: InkWell(
//       onTap: ()=> onTap!(),
//       child: Icon(
//         Icons.west,
//         color: itemColor ?? AppColors.black,
//       ),
//     ),
//     title: Text(
//       title,
//       style: TextStyle(
//           color: itemColor ?? AppColors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 16.sp),
//     ),
//   );
// }