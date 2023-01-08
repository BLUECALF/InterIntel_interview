
// list tiles of options in the profiles are made here
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';
import '../utils/HelpfulFunctions.dart';

Widget make_list_tile(String text,IconData icon_data,VoidCallback function)
{
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.only(left: 0),
    title: Text(text,
        style:TextStyle(
            fontSize: 15.sp, fontWeight: FontWeight.w400
        )
    ),leading: Container(
    width: 43.sp,
      height: 43.sp,
      padding: EdgeInsets.all(0),
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: color_blue_light
      ),
      child: Icon(icon_data,color: Colors.white,size: 25.sp,)),
    onTap: function,
  );
}
Widget make_social_list_tile(String text,String iconPath,VoidCallback function)
{
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.only(left: 0),
    title: Text(text,
        style:TextStyle(
            fontSize: 15.sp, fontWeight: FontWeight.w400
        )
    ),leading: Container(
    width: 43.sp,
      height: 43.sp,
      padding: EdgeInsets.all(0),
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: color_blue_light
      ),
      child: Image.asset(iconPath)),
    onTap: function,
  );
}
Widget make_pink_list_tile({required Widget child,required IconData icon_data})
{
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    title: child,
    leading: Container(
      width: 43.w,
      height: 43.h,
      padding: EdgeInsets.all(0),
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: color_pink
      ),
      child: Icon(icon_data,color: Colors.white,size: 25.sp,)),
  );
}