
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget MakeStar({double? left,double? right,double? top,double? bottom,Color? color})
{
  return Positioned(
    right: right,
    left: left,
    top: top,
    bottom: bottom,
    child: SizedBox(
        width: 47.w,
        height: 47.h,
        child: Image.asset("assets/images/star.png",color: color,))
  );
}