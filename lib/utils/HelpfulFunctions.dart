import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carrier_info/carrier_info.dart';
import 'package:interintel_interview/pages/CommonPage.dart';
import 'package:interintel_interview/styles/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

String getNameInitials(full_name) {
  if (full_name == null) {
    return "";
  }
  List<String> names = full_name.split(" ");
  String initials = "";
  int numWords = 2;

  numWords = names.length;
  for (var i = 0; i < numWords; i++) {
    if (names[i] == "") {
      initials += "";
    } else {
      initials += '${names[i].substring(0, 1)}';
      if (initials.length == 2) {
        return initials;
      }
    }
  }
  return initials;
}

// permisions
void getPermission() async {
  Map<Permission, PermissionStatus> statuses =
      await [Permission.contacts, Permission.phone].request();
  print(statuses[Permission.contacts]);
  // if peremission is denied , reask permission
  if (await Permission.contacts.isPermanentlyDenied) {
    return;
  }
  if (await Permission.contacts.isDenied ||
      await Permission.contacts.isRestricted) {
    getPermission();
  }
}

String getLastName({required String fullName}) {
  List<String> nameList = fullName.split(" ");
  print("name list is $nameList");
  var lastname = nameList[nameList.length - 1];
  if (lastname == " " || lastname == "" || lastname == "  ") {
    return nameList[nameList.length - 2];
  } else
    return nameList[nameList.length - 1];
}

Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

Future<bool> hasSimCard() async {
  try {
    String? carrierInfo = await CarrierInfo.mobileNetworkCode;
    if (carrierInfo == null) {
      return false;
    } else
      return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<void> LaunchURL({required var link}) async {
  var url = Uri.parse(link);
  if (await canLaunchUrl(url))
    await launchUrl(url);
  else
    // can't launch url, there is some error
    Get.defaultDialog(title: "Error", content: Text("Could not open $link"));
}

String? getDate(List timelineState) {
  RegExp dateExp = new RegExp(
    r"([0-9.]{8})\w+",
  );
  String time_and_date = timelineState[2]["time"].toString();

  var date = dateExp.firstMatch(time_and_date);
  if (date == null) {
    return "";
  }
  return date[0];
}

String? getTime(List timelineState) {
  RegExp timeExp = new RegExp(
    r"([0-9:]{6})\w+",
  );
  String time_and_date = timelineState[2]["time"].toString();

  var time = timeExp.firstMatch(time_and_date);

  if (time == null) {
    return "";
  }
  return time[0];
}

Future<void> acceptTermsDialog(BuildContext context) async {
  print(" acccept was called::::");
  Get.defaultDialog(
    barrierDismissible: false,
    radius: 0,
    titlePadding: EdgeInsets.all(20.sp),
    titleStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22.sp,
        letterSpacing: (3 / 100 * 22).w),
    title: "Terms & Conditions",
    content: Column(
      children: [
        Text(
          "By using our services you agree to the Privpay  Terms and Conditions.",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              letterSpacing: (3 / 100 * 15).w),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 19.h,
        ),
        TextButton(
          onPressed: () {
            LaunchURL(link: "https://priv-pay.com/terms.html");
          },
          child: Text(
            "Read Terms and Conditions",
            style: TextStyle(
                color: color_pink,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                letterSpacing: (3 / 100 * 15).w),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                  Get.off(() => CommonPage());
                },
                child: Text("I agree")),
            OutlinedButton(onPressed: () {
              final snackBar = SnackBar(
                content: const Text('In order to use InterIntel You must accept the terms & conditions'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, child: Text("Cancel"))
          ],
        )
      ],
    ),
  );
}

bool is_square_screen({required double width,required double height})
{
  double ratio = height / width;
  if(ratio >= 1.5)
    {
      return false;
    }
  else return true;
}

/// wrapper to make widgets interactive

Widget wrapper({required Widget childWidget})
{
  // set screen orinetation to potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
 return ScreenUtilInit(
   designSize: is_square_screen(width: Get.width, height: Get.height)?Size(Get.width,926): Size(428, 926),
  builder: (context,child) => childWidget,
 );
}


String? safaricomNumberValidator(String? phoneNumber)
{
  if (phoneNumber!.startsWith("0110") ||
      phoneNumber.startsWith("0111") ||
      phoneNumber.startsWith("0112") ||
      phoneNumber.startsWith("0113") ||
      phoneNumber.startsWith("0114") ||
      phoneNumber.startsWith("0115") ||
      phoneNumber.startsWith("070") ||
      phoneNumber.startsWith("071") ||
      phoneNumber.startsWith("072") ||
      phoneNumber.startsWith("0740") ||
      phoneNumber.startsWith("0741") ||
      phoneNumber.startsWith("0742") ||
      phoneNumber.startsWith("0743") ||
      phoneNumber.startsWith("0745") ||
      phoneNumber.startsWith("0746") ||
      phoneNumber.startsWith("0748") ||
      phoneNumber.startsWith("0757") ||
      phoneNumber.startsWith("0758") ||
      phoneNumber.startsWith("0759") ||
      phoneNumber.startsWith("0768") ||
      phoneNumber.startsWith("0769") ||
      phoneNumber.startsWith("079")) {
    return null;
  } else {
    return "Enter a Safaricom number";
  }
}

String errorResponseHandler(String errorString)
{
  String response;
  if(errorString == "DS timeout user cannot be reached")
    response = "TRANSACTION TIMEOUT PLEASE TRY AGAIN";
  else if(errorString == "The initiator information is invalid.")
    response = "YOU ENTERED WRONG PIN, TRY AGAIN";
  else
    response = errorString;
  return response;
}