import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/utils/HelpfulFunctions.dart';
import 'package:privpay/utils/priv_pay_icons.dart';
import 'package:privpay/widgets/make_list_tile.dart';

class HelpPage extends GetView {
  //final RestController rest = Get.find<RestController>();
  //final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return wrapper(
      childWidget: Scaffold(
          body: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 100.h,
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
                          size: 20.sp,
                        )),
                    SizedBox(
                      width: 52.w,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Help & Support",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: (3/100 * 22).w
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Collum of tiles
                Container(
                  padding: EdgeInsets.only(left: 39.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Support", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400,letterSpacing: (2.29/100 * 15).w)),
                    SizedBox(height: 30.h),
                    Column(
                      children: [
                        make_list_tile("Call Support", PrivPay.suport_icon, () {LaunchURL(link: "whatsapp://send?phone=+254110652438&text=${Uri.parse("Hi PrivPay")}");}),
                        make_list_tile("FAQ", PrivPay.faqs, () {LaunchURL(link: "https://priv-pay.com/index.html#faqs");}),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text("Social", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400,letterSpacing: (2.29/100 * 15).w)),
                    SizedBox(height: 13.h),
                    Column(
                      children: [
                        make_social_list_tile(
                            "Twitter", "assets/images/Layer 2.png", () {LaunchURL(link: "https://twitter.com/priv_pay");}),
                        make_social_list_tile(
                            "Facebook", "assets/images/facebook 1.png", () {LaunchURL(link: "https://web.facebook.com/profile.php?id=100087231567799");}),
                        make_social_list_tile(
                            "Instagram", "assets/images/instagram 1.png", () {LaunchURL(link: "https://www.instagram.com/privpayke/");}),
                      ],
                    ),
                    SizedBox(height: 56.h),
                    Text("About", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400,letterSpacing: (2.29/100 * 15).w)),
                    SizedBox(height: 9.h),
                    Column(
                      children: [
                        make_list_tile("Rate us on App Store", PrivPay.rate_1, () {}),
                        make_list_tile(
                            "Terms and Conditions", PrivPay.terms_and_conditions, () {LaunchURL(link: "https://priv-pay.com/terms.html");}),
                        make_list_tile("Privacy Policy", PrivPay.privacy_policy_1, () {LaunchURL(link: "https://priv-pay.com/privacy.html");}),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],),
                ),
              ]))),
    );
  }
}
