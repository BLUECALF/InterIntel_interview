import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:privpay/controllers/AppController.dart';
import 'package:privpay/controllers/CommonPageController.dart';
import 'package:privpay/pages/services/AccountEditPage.dart';
import 'package:privpay/styles/colors.dart';
import 'package:privpay/styles/make_input_decoration.dart';
import 'package:privpay/utils/HelpfulFunctions.dart';
import 'package:privpay/utils/priv_pay_icons.dart';
import 'package:privpay/widgets/make_list_tile.dart';

class AccountPage extends GetView {
  final _formKey = GlobalKey<FormBuilderState>();
  final AppController appController = Get.find<AppController>();
  late CommonPageController? commonPageController = null;
  late PageController? pageController = null;
  var errorText = "".obs;

  @override
  Widget build(BuildContext context) {
    if (appController.isFirstTime() == false) {
      /// initialize commonpage controller and page controller
      commonPageController = Get.find<CommonPageController>() != null
          ? Get.find<CommonPageController>()
          : null;
      pageController = Get.find<PageController>() != null
          ? Get.find<PageController>()
          : null;
    }
    return wrapper(
      childWidget: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: Text("Account",
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: (8 / 100 * 26).sp)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(35.215.sp),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: color_blue_light),
                        child: Obx(
                          () => Text(
                            "${getNameInitials(appController.nickName.value.capitalize)}",
                            style: TextStyle(
                                color: color_white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: (5 / 100 * 17).w),
                          ),
                        )),
                  ),
                ]),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => AccountEditPage());
                      },
                      child: Text("Edit Profile")),
                ),

                /// FORM TO HAVE USER DATA
                FormBuilder(
                  enabled: false,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      FormBuilderTextField(
                        initialValue: appController.getPhone(),
                        name: 'phone',
                        decoration: makeInputDecoration(
                            "Enter Number", null, errorText.value),
                        onChanged: (String? val) {
                          errorText.value = '';
                        },
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 10),
                          FormBuilderValidators.integer(context),
                          FormBuilderValidators.numeric(context,
                              errorText: "Enter numbers only"),
                          (val) {
                            if (val!.contains(" ")) {
                              return "Remove the Spaces.";
                            } else
                              return null;
                          },
                          FormBuilderValidators.maxLength(context, 10),
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FormBuilderTextField(
                        initialValue: appController.getPIN(),
                        name: 'pin',
                        decoration: makeInputDecoration(
                            "Enter PIN", null, errorText.value),
                        obscureText: true,
                        onChanged: (String? val) {
                          errorText.value = '';
                        },
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context,
                              errorText: "Enter numbers only"),
                          FormBuilderValidators.integer(context),
                          (val) {
                            if (val!.contains(" ")) {
                              return "Remove the Spaces.";
                            } else
                              return null;
                          },
                          FormBuilderValidators.minLength(context, 4),
                          FormBuilderValidators.maxLength(context, 4),
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FormBuilderTextField(
                        initialValue: appController.getNickName(),
                        name: 'nickName',
                        textCapitalization: TextCapitalization.characters,
                        decoration: makeInputDecoration(
                            "Enter NickName", null, errorText.value),
                        onChanged: (String? val) {
                          errorText.value = '';
                        },
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                        keyboardType: TextInputType.text,
                      ),
                      make_pink_list_tile(
                          child: FormBuilderSwitch(
                            initialValue: appController.mustSaveTransaction(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                            ),
                            name: "saveTransactions",
                            title: Text("Save transactions",
                                style: TextStyle(fontSize: 16.sp)),
                          ),
                          icon_data: PrivPay.terms_and_conditions),
                      make_pink_list_tile(
                          child: FormBuilderSwitch(
                            initialValue: appController.mustAuthenticate(),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: false,
                                contentPadding: EdgeInsets.zero),
                            name: "localAuth",
                            title: Text("Local Authentication",
                                style: TextStyle(fontSize: 16.sp)),
                          ),
                          icon_data: Icons.fingerprint),
                    ],
                  ),
                ),
              ]),
        ),
      )),
    );
  }
}
