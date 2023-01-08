import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interintel_interview/styles/colors.dart';

Widget share_button({required VoidCallback function}) {
  return Column(
    children: [
      Container(
          height: 40.sp,
          width: 40.sp,
          decoration:
              new BoxDecoration(shape: BoxShape.circle, color: color_blue_light),
          child: IconButton(
            icon: Icon(
              Icons.share,
              size: 18.sp,
              color: color_white,
            ),
            onPressed: function,
          )),
      SizedBox(height: 3.sp,),
      Text("Share",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp),)
    ],
  );
}

Widget save_button({required VoidCallback function}) {
  return Column(
    children: [
      Container(
          height: 40.sp,
          width: 40.sp,
          decoration:
              new BoxDecoration(shape: BoxShape.circle, color: color_blue_light),
          child: IconButton(
            icon: Icon(
              Icons.download,
              size: 18.sp,
              color: color_white,
            ),
            onPressed: function,
          )),
      SizedBox(height: 3.sp,),
      Text("Save",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp))
    ],
  );
}
