
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/style/appColors.dart';

class CustomPopMenuBarWidget extends ConsumerWidget {
 
  final Function(String) onSelected;
  final Widget? icon;
   final List<PopupMenuItem<String>> item;
  const   CustomPopMenuBarWidget( 
      {this.icon, required this.onSelected, required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return PopupMenuButton<String>(
      color: AppColors.white,
      padding: EdgeInsets.zero,
      iconSize: 20.w,
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => item,
    );
  }
}


