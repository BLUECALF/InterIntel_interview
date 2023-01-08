import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:privpay/controllers/AppController.dart';
import 'package:privpay/controllers/CommonPageController.dart';
import 'package:privpay/pages/services/ConfirmPage.dart';
import 'package:privpay/styles/make_input_decoration.dart';

import '../../utils/HelpfulFunctions.dart';

class SendPage extends GetView {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();

  //final RestController rest = Get.find<RestController>();
  final AppController appController = Get.put(AppController());
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
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 89.h),
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Text("Initiate Payment",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: (3 / 100 * 24).w)),
                ),
                SizedBox(height: 19.h),
                Container(
                  width: 332.w,
                  height: 42.h,
                  padding: EdgeInsets.only(left: 26.w),
                  child: Text(
                      "Enter your destination number and amount to proceed",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: (3 / 100 * 12).w)),
                ),
                Obx(
                  () => FormBuilder(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 23.w, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 45.h,
                          ),
                          FormBuilderTextField(
                            controller: phoneTextEditingController,
                            name: 'phoneNumber',
                            decoration: makeInputDecoration(
                                "Enter Number",
                                TextButton(
                                  onPressed: () async {
                                    await getPhoneNumber();
                                  },
                                  child: Icon(Icons.search),
                                ),
                                errorText.value),
                            onChanged: (String? val) {
                              errorText.value = '';
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              safaricomNumberValidator,
                              FormBuilderValidators.minLength(context, 10,
                                  errorText: "Must be 10 digits"),
                              FormBuilderValidators.notEqual(
                                  context, appController.getPhone(),
                                  errorText: "cannot send to yourself"),
                              FormBuilderValidators.maxLength(context, 10,
                                  errorText: "Must be 10 digits"),
                              FormBuilderValidators.integer(context,errorText: numberErrorText),
                                  (val){
                                if(val!.contains(" "))
                                {
                                  return numberErrorText;
                                }
                                else return null;
                              },
                              FormBuilderValidators.numeric(context,
                                  errorText: numberErrorText)
                            ]),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 39.h,
                          ),
                          FormBuilderTextField(
                            name: 'amount',
                            controller: amountTextEditingController,
                            decoration: makeInputDecoration(
                                "Enter amount", null, errorText.value),
                            onChanged: (String? val) {
                              errorText.value = '';
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.min(context, 100),
                              FormBuilderValidators.numeric(context,
                                  errorText: numberErrorText),
                              FormBuilderValidators.integer(context,errorText: numberErrorText),
                              (val){
                              if(val!.contains(" "))
                                {
                                  return numberErrorText;
                                }
                              else return null;
                              },
                              FormBuilderValidators.max(context, 70000)
                            ]),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 39.h,
                          ),
                          FormBuilderTextField(
                            initialValue: "",
                            name: 'description',
                            decoration: makeInputDecoration(
                                "Enter Description", null, errorText.value),
                            onChanged: (String? val) {
                              errorText.value = '';
                            },
                            // valueTransformer: (text) => num.tryParse(text),

                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 39.h,
                          ),
                          FormBuilderTextField(
                            initialValue: appController.getNickName(),
                            name: 'nickName',
                            decoration: makeInputDecoration(
                                "Enter Nickname", null, errorText.value),
                            onChanged: (String? val) {
                              errorText.value = '';
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 42.h,
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
                                      "Proceed",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }

  void _onContinue() async {
    if (_formKey.currentState!.saveAndValidate()) {
      Map data = _formKey.currentState!.value;
      print("Data in Send is \n $data");
      var pageResult = await Get.to(() => ConfirmPage(), arguments: data);
      if (pageResult == "clear") {
        phoneTextEditingController.text = "";
        amountTextEditingController.text = "";
      }
    }
  }

  Future<void> getPhoneNumber() async {
    if (await Permission.contacts.isDenied) {
      print("i permanently denied was called");
      Get.defaultDialog(
          title: "Error",
          content: Text(
              "You denied the app permission to contacts. Go to settings and give permission to access contacts"),
          textConfirm: "Go to settings",
          onConfirm: () {
            openAppSettings();
          });
      return;
    } else {
      print(" not denied code was called");
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      if (contact != null) {
        String number = contact.phoneNumber!.number!;
        phoneTextEditingController.text = number
            .replaceAll(" ", "")
            .replaceAll("+254", "0")
            .replaceAll("-", "");
        print("contact phone :: ${contact.phoneNumber}");
      }
    }
  }
}
