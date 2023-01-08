import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/controllers/AppController.dart';
import 'package:privpay/styles/colors.dart';

import '../../utils/HelpfulFunctions.dart';
import '../review_timeline/ReviewTimelinePage.dart';

class NotificationPage extends GetView {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return wrapper(
      childWidget: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25.sp,
                            )),
                        SizedBox(
                          width: 60.w,
                        ),
                        Text("Notifications",
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: (3/100 * 22).w)),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w,right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ITS OTHER WIDGETS
                          Text(
                            "Failed Transactions",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 31.h,
                          ),
                          Column(
                            children: appController.getTransactions().reversed.toList().map((e) {
                              var failed = e.firstWhere(
                                      (element) =>
                                  element["status"] == "StageStatus.FAILED",
                                  orElse: () => null);
                              if (failed != null) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(
                                    Icons.error,
                                    color: color_red,
                                    size: 50,
                                  ),
                                  title: Text(failed["message"].toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  onTap: (){Get.to(() => ReviewTimelinePage(),arguments: {"data": e});},
                                  subtitle : Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(failed["time"] == null?"":failed["time"].split(" ")[0].toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      Text(failed["time"] == null?"": failed["time"].split(" ")[1].toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // transaction succeded and wont be shown here
                                return SizedBox();
                              }
                            }).toList(),
                          ),
                        ],
                      ),
                    )

                  ]),
                )),
          )),
    );
  }
}
