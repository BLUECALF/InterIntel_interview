import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import "package:flutter/material.dart";
import 'package:interintel_interview/controllers/AppController.dart';
import 'package:interintel_interview/controllers/CommonPageController.dart';
import 'package:interintel_interview/pages/CommonPage.dart';
import 'package:interintel_interview/styles/colors.dart';
import 'package:interintel_interview/styles/make_input_decoration.dart';
import 'package:interintel_interview/utils/HelpfulFunctions.dart';
import 'package:interintel_interview/widgets/make_list_tile.dart';

class InfoPage extends GetView {
  final _formKey = GlobalKey<FormBuilderState>();
  final AppController appController = Get.find<AppController>();
  final CommonPageController commonPageController =
      Get.find<CommonPageController>();
  var errorText = "".obs;
  var numberErrorText =
      "Check number input, spaces and special characters not allowed";

  @override
  Widget build(BuildContext context) {
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
                  height: 90.h,
                ),
                Center(
                  child: Text(
                      appController.isFirstTime()
                          ? "Create Account"
                          : "Edit Info",
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: (8 / 100 * 26).sp)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                !appController.isFirstTime()
                    ? Center(
                        child: Container(
                            padding: EdgeInsets.all(35.215.sp),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: color_blue_light),
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
                      )
                    : SizedBox(),

                /// FORM TO HAVE USER DATA
                FormBuilder(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      FormBuilderTextField(
                        initialValue: appController.getName(),
                        name: 'name',
                        textCapitalization: TextCapitalization.characters,
                        decoration: makeInputDecoration(
                            "Enter name", null, errorText.value),
                        onChanged: (String? val) {
                          errorText.value = '';
                        },
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                        keyboardType: TextInputType.text,
                      ),
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
                          safaricomNumberValidator,
                          FormBuilderValidators.minLength(context, 10),
                          FormBuilderValidators.integer(context,
                              errorText: numberErrorText),
                          FormBuilderValidators.numeric(context,
                              errorText: numberErrorText),
                          (val) {
                            if (val!.contains(" ")) {
                              return numberErrorText;
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
                        initialValue: appController.getEmail(),
                        name: 'email',
                        textCapitalization: TextCapitalization.characters,
                        decoration: makeInputDecoration(
                            "Enter email address", null, errorText.value),
                        onChanged: (String? val) {
                          errorText.value = '';
                        },
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      make_pink_list_tile(
                          child: FormBuilderSwitch(
                              initialValue: appController.saveDetails(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                filled: false,
                              ),
                              name: "saveMe", title: Text("Save My details")),
                          icon_data: Icons.save),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Container(
                          height: 60.h,
                          width: 382.w,
                          child: ElevatedButton(
                              onPressed: _onContinue,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      )),
    );
  }

  void _onContinue() {
    //
    if (_formKey.currentState!.saveAndValidate()) {
      Map data = _formKey.currentState!.value;
      print("the data in settings $data");

      // if is first time go to common else get.back
      if (appController.isFirstTime()) {
        if(data["saveMe"])
        appController.register(data);

        appController.update_details_in_state(data);
        /// make common page take user to the design tab
        commonPageController.selected_index.value = 1;
      } else {
        if(data["saveMe"])
          appController.register(data);

        appController.update_details_in_state(data);
        Get.back();
        Get.defaultDialog(
            title: "Success",
            content: Text("Account Details Updated"),
            textConfirm: "OK",
            onConfirm: () {
              Get.back();
            });

        /// make common page take user to the design tab
        commonPageController.selected_index.value = 1;
      }
    }
  }
}
