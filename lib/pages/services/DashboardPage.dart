import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/controllers/AppController.dart';
import 'package:privpay/pages/search/search_delegate.dart';
import 'package:privpay/pages/services/HelpPage.dart';
import 'package:privpay/pages/services/NotificationPage.dart';
import 'package:privpay/styles/colors.dart';
import 'package:privpay/utils/HelpfulFunctions.dart';
import 'package:privpay/utils/priv_pay_icons.dart';
import 'package:privpay/widgets/make_list_tile.dart';

class DashboardPage extends StatelessWidget {
  AppController appController = Get.put(AppController());
  PageController pageController = Get.find<PageController>();
  TextEditingController queryController = TextEditingController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return wrapper(
      childWidget: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(HelpPage());
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: 24.sp,
                                ))),
                        Expanded(
                          flex: 7,
                          child: Text(
                            "",
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () async {
                                await showSearch(
                                    context: context,
                                    delegate: MySearchDelegate(queryController));

                                // filter the result
                                switch (queryController.text) {
                                  case "send":
                                    pageController.jumpToPage(1);
                                    break;
                                  case "account":
                                    pageController.jumpToPage(2);
                                    break;
                                  case "":
                                    pageController.jumpToPage(0);
                                    break;
                                }
                              },
                              icon: Icon(PrivPay.search, size: 24.sp)),
                        ),
                        SizedBox(
                          width: 24.sp,
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                Get.to(NotificationPage());
                              },
                              icon: Icon(
                                PrivPay.notification,
                                size: 24.sp,
                              )),
                        ),
                      ],
                    ),
                    Text(
                      "Welcome ${getLastName(fullName: appController.getNickName()).capitalizeFirst},",
                      style:
                          TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 39.h,),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: spendingsCardGradient),
                      height: 180.h,
                      width: 396.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.h,),
                          Text("Total Spends For This Month",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 19.sp,
                                color: color_white,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(height: 9.h),
                          Text(
                              "Ksh ${appController.getTotalSpends().toString()}",
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: color_white,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: 2.h),
                          Text(
                              "Last payment Ksh ${appController.getLastSpendAmount().toString()}.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: color_white,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 51.h,),
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                    Column(
                      children: appController.getTransactions().reversed.toList().map((e) {
                        var failed = e.firstWhere(
                            (element) =>
                                element["status"] == "StageStatus.FAILED",
                            orElse: () => null);
                        if (failed == null) {
                          count ++;  // don't make list tile after 10 transactions
                          if(count > 10){ return SizedBox();}
                          return make_transaction_list_tile(
                              e[2]["receiverParty"].split("-")[1],
                              e[2]["amount"],
                              getDate(e).toString(),
                              e as List);
                        } else {
                          //transaction failed and wont be shown here
                          return SizedBox();
                        }
                      }).toList(),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
