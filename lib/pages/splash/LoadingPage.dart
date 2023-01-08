import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interintel_interview/controllers/AppController.dart';

import '../../styles/colors.dart';
import '../../utils/HelpfulFunctions.dart';
import '../CommonPage.dart';

class LoadingPage extends StatelessWidget {
  AppController appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    goToSplash(context);
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: 400.h,),
          SizedBox(
            width: 320.w,
              height: 110.h,
              child: Image.asset("assets/images/interintel_logo.JPG")),
          SizedBox(height: 300.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("From ",style: TextStyle(
                 color: color_gray_light,
                 fontSize: 25.sp,
                 letterSpacing: (7/100 *25).w,
                 fontWeight: FontWeight.w300
             ),),
             Text("InterIntel",style: TextStyle(
                 color: color_gray_light,
                 fontSize: 25.sp,
                 letterSpacing: (7/100 * 25).w,
                 fontWeight: FontWeight.bold
             ),),
           ],
          )
        ],
      ),
    );
  }
  void goToSplash(BuildContext context) async
  {
    await Future.delayed(Duration(milliseconds: 5000));
    // if is not first time => common page
    if(appController.isFirstTime())
    {
      await acceptTermsDialog(context);

    }
    else
        Get.off(()=> CommonPage());
  }
}
