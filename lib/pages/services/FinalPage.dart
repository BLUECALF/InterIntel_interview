import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/controllers/AppController.dart';
import 'package:privpay/pages/receipt/ReceiptPage.dart';
import 'package:privpay/services/firebase_analytics.dart';
import 'package:privpay/widgets/make_share_and_save_button.dart';
import '../../utils/HelpfulFunctions.dart';
import '../../widgets/make_animated_icon.dart';

class FinalPage extends GetView {
  var timelineState = [];
  AppController appController = Get.find<AppController>();
  AnalyticsService analyticsService = Get.find<AnalyticsService>();

  @override
  Widget build(BuildContext context) {
    timelineState = Get.arguments["data"];
    print("the timeline state in Final page is \n\n $timelineState \n\n");
    return wrapper(
      childWidget: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                determineWholePage(timelineState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget determineWholePage(List timelineState) {
    var failed = timelineState.firstWhere(
        (element) => element["status"] == "StageStatus.FAILED",
        orElse: () => null);
    if (failed == null) {
      // the whole transaction passed.

      ///  broadcast transaction success to mixpanel
      appController.broadcastMixTransactionSuccess();
      analyticsService.broadcastTransactionSuccess();
      return Column(
        children: [
          SizedBox(height: 98.h,),
          Text("Payment Complete",
              style: TextStyle(
                  fontSize: 24.sp, fontWeight: FontWeight.w500,
                letterSpacing: (7/100 * 24).w
              )),
          SizedBox(height: 14.h,),
          PrivPayAnimatedIcon(
            jsonPath: "assets/json/82060-successful-transaction.json",
            size: 312,
          ),
          SizedBox(
            height: 17.h,
          ),
          Card(
            child: Container(
              width: 428.w,
              height: 439.h,
              padding: EdgeInsets.only(left: 40.w,right: 40.w),
              child: Column(
                children: [
                  SizedBox(height: 3.h,),
                  PrivPayAnimatedIcon(
                    jsonPath: "assets/json/79952-successful.json",
                    size: 161,
                  ),
                  Text("Thank You For using PrivPay Services",
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w500,letterSpacing: (3/100 * 17).w)),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(timelineState[1]["message"].toString(),
                      style: TextStyle(
                          letterSpacing: (3/100 * 12).w,
                          fontSize: 12.sp, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      save_button(function: () {
                        if(appController.mustSaveTransaction())
                        {
                          // had been saved on Transaction timeline ... do nothing
                        }
                        else
                          appController.saveTransaction(timelineState);
                        Get.defaultDialog(title: "Success",content: Text("Transaction Saved"),
                            textConfirm: "OK",
                            onConfirm: (){
                              Get.back();
                            });
                      }),
                      share_button(function: () {
                        Get.to(()=> ReceiptPage(),arguments: {"data": timelineState});
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Container(
                    height: 43.h,
                    width: 342.w,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.back(result: "clear");
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Done",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )         
        ],
      );
    } else {
      // The whole transaction Failed.
      ///  broadcast transaction Failed to mixpanel
      appController.broadcastMixTransactionFailure();
      analyticsService.broadcastTransactionFailure();
      return Column(
        children: [
          SizedBox(
            height: 96.h,
          ),
          Text("Payment Failed",
              style: TextStyle(
                  letterSpacing: (7/100 * 24).w,
                  fontSize: 24.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 15.h,),
          PrivPayAnimatedIcon(
            jsonPath: "assets/json/102132-card-payment-unsuccessful.json",
            size: 312,
          ),
          SizedBox(
            height: 100.h,
          ),
          Card(
            elevation: 10,
            child: Container(
              width: 428.w,
              height: 357.h,
              child: Column(
                children: [
                  SizedBox(height: 17.h,),
                  PrivPayAnimatedIcon(
                    jsonPath: "assets/json/56132-error.json",
                    size: 108,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text("Transaction Failed",
                      style: TextStyle(
                          letterSpacing: (3/100 * 20).w,
                          fontSize: 20.sp, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 26.h,
                  ),
                  AutoSizeText(failed["message"].toString(),
                      maxLines: 2,
                      style: TextStyle(
                          letterSpacing: (3/100 * 12).w,
                          fontSize: 12.sp, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 47.h,
                  ),
                  Container(
                    height: 43.h,
                    width: 342.w,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Try Again",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),          
        ],
      );
    }
  }
}
