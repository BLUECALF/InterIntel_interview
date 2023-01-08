import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration makeInputDecoration(String hint,Widget? suffixIcon,String errorText)
{
  return InputDecoration(
    errorMaxLines: 2,
    errorStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: (3/100 *12).w
    ),
    contentPadding: EdgeInsets.only(left: 20.w,right: 20.w),
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: (3/100 * 14).w
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
      ),
      errorText: errorText.length > 0
          ? errorText
          : null
      );
}