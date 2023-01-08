
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
Widget make_transaction_list_tile(String text,String amount,String date,List timelineState)
{
  return Card(
    elevation: 0,
    child: ListTile(
      contentPadding: EdgeInsets.only(left: 10.sp,right: 10.sp),
      title: Text(text.trim(),
          maxLines: 1,
          style:TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w400
          )
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date,
              style:TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400
              )
          ),
          Text(getTime(timelineState).toString(),
              style:TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
              )
          ),
        ],
      ),
      trailing: Text("Ksh. $amount",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w400),),
      leading: Container(
        padding: EdgeInsets.all(20.5.sp),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: color_blue_light
        ),
        child: Text(
            getNameInitials(text),
          style: TextStyle(
            color: color_white,
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
    ),
      onTap: (){Get.to(() => ReviewTimelinePage(),arguments: {"data": timelineState});},
    ),
  );
}
Widget make_contact_list_tile(String name,List<Item>? itemList)
{
  return Card(
    elevation: 0,
    color: color_white,
    child: ListTile(
      contentPadding: EdgeInsets.only(left: -20,right: 10),
      title: AutoSizeText(name,
          maxLines: 2,
          style:TextStyle(
            fontSize: 15,
          )
      ),
      subtitle: Text(getPhoneFromItem(itemList!),
          style:TextStyle(
              fontSize: 10
          )
      ),
      leading: Container(
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: color_blue_light
        ),
        child: Text(
            getNameInitials(name),
          style: TextStyle(
            color: color_white,
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        )
    ),
    ),
  );
}

String getPhoneFromItem(List<Item> itemList)
{
  if(itemList.length == 0 || itemList == null)
    {
      return "";
    }
  else
    {
      return itemList[0].value.toString();
    }
}