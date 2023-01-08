import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/pages/services/TransactionTimelinePage.dart';
import 'package:privpay/services/firebase_analytics.dart';
import 'package:privpay/styles/colors.dart';
import 'package:privpay/utils/priv_pay_icons.dart';
import 'package:privpay/widgets/make_pen_icon_button.dart';

import '../../api/api.dart';
import '../../controllers/AppController.dart';
import '../../utils/HelpfulFunctions.dart';

class ConfirmPage extends GetView {
  //final RestController rest = Get.find<RestController>();
  final AppController appController = Get.find<AppController>();
  final AnalyticsService analyticsService = Get.find<AnalyticsService>();

  @override
  Widget build(BuildContext context) {
    appController.initMixpanel();
    Map data = Get.arguments;
    var phone, amount, description, nickName = "";
    if (data != null) {
      phone = data["phoneNumber"];
      amount = data["amount"];
      description = data["description"];
      nickName = data["nickName"];
    }
    return wrapper(
      childWidget: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 17.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          PrivPay.cancel,
                          size: 24.sp,
                        )),
                  ],
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text("Confirm",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: (3 / 100 * 24).sp)),
                SizedBox(height: 85.h),
                Container(
                  height: 450.h,
                  width: 346.w,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(12.5.sp),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle, color: color_blue_light),
                            child: Text(
                              getNameInitials("Priv Pay"),
                              style: TextStyle(
                                  color: color_white,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: (3 / 100 * 19).sp),
                            )),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("Send To",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: (3 / 100 * 18).sp)),
                          subtitle: Text(phone,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: (3 / 100 * 18).sp)),
                          trailing: pen_icon_button(),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("Amount",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: (3/100 * 18).sp)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ksh $amount",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: (3/100 * 18).sp)),
                              FutureBuilder(
                                future: calculateFee(amount),
                                builder: (c, s) {
                                  if (s.data == null) {
                                    return Text("Loading....",
                                        style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: (3/100 * 14).sp));
                                  }
                                  else {
                                    /// we have otten convinience fee.
                                    appController.broadcastMixSuccessFetchingConvenienceFee();
                                    analyticsService.broadcastSuccessFetchingConvenienceFee();
                                    return Text("Fee : Ksh ${s.data}",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: (3 / 100 * 14).sp));
                                  }
                                },
                              ),
                            ],
                          ),
                          trailing: pen_icon_button(),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("Description",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: (3/100 * 18).sp)),
                          subtitle: Text(description,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: (3/100 * 18).sp)),
                          trailing: pen_icon_button(),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          title: Text("Nickname",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: (3/100 * 18).sp)),
                          subtitle: Text(nickName,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: (3/100 * 18).sp)),
                          trailing: pen_icon_button(),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 66.h,
                ),
                Container(
                  height: 60.h,
                  width: 382.w,
                  child: ElevatedButton(
                      onPressed: () {
                        _onContinue(data);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Send",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )),
                ),
              ],
            )),
      )),
    );
  }

  void _onContinue(Map data) async {
    if (await hasSimCard()) {
      if (await hasInternet()) {
        // has confirmed transaction details ... broadcat
        appController.broadcastMixPaymentDetailsConfirmation();
        analyticsService.broadcastPaymentDetailsConfirmation();
        Get.to(() => TransactionTimelinePage(), arguments: data);
      } else
        Get.defaultDialog(title: "You have no internet", content: Text(""));
    } else {
      Get.defaultDialog(title: "You have no sim card", content: Text(""));
    }
  }

  Future<String> calculateFee(String amount) async {
    var result = await PrivPayApi.getCharges(amount);
    if (result["status"] == 0) {
      // success in get charges
      int charge = result["charges"].ceil();
      return charge.toString();
    } else {
      return result["message"].toString();
    }
  }
}
