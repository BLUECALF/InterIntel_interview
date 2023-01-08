import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:interintel_interview/controllers/AppController.dart';
import 'package:interintel_interview/controllers/CommonPageController.dart';
import 'package:interintel_interview/styles/colors.dart';
import 'package:interintel_interview/utils/HelpfulFunctions.dart';
import 'package:interintel_interview/widgets/make_animated_icon.dart';

class DesignPage extends GetView {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    displayApproperiatePage();
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Text("Design",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: (8 / 100 * 26).sp)),
          SizedBox(
            height: 30.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.sp),
            child: GradientCard(
                gradient: designsGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          padding: EdgeInsets.all(35.215.sp),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle, color: color_blue_dark),
                          child: Obx(
                            () => Text(
                              "${getNameInitials(appController.name.value.capitalize)}",
                              style: TextStyle(
                                  color: color_white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: (5 / 100 * 17).w),
                            ),
                          )),
                    ),
                    Text("Name  : ${appController.name.value}"),
                    Text("Phone : ${appController.phone.value}"),
                    Text("Email : ${appController.email.value}"),
                    Text("Saved : ${appController.saveMe.value}"),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                )),
          ),
          FutureBuilder(
            future: hasInternet(),
            builder: (c, s) {
              if (s.data == null) {
                return Text("loading .... ");
              }
              if (s.data == false) {
                return PrivPayAnimatedIcon(
                    jsonPath: "assets/json/offline.json", size: 360,repeat: true,);
              } else
                return PrivPayAnimatedIcon(
                    jsonPath: "assets/json/monkey.json", size: 360,repeat: true,);
            },
          )
        ],
      ),
    );
  }

  void displayApproperiatePage() {
    if(appController.name.value == "")
      {
        // we have no name ... no user  -> force signup
        CommonPageController commonPageController = Get.find<CommonPageController>();
        PageController _pageController = Get.find<PageController>();
        commonPageController.selected_index.value = 0;
        _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
      }
  }
}
