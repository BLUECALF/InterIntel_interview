import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:interintel_interview/widgets/make_list_tile.dart';

import '../../api/api.dart';
import '../../styles/colors.dart';

class ResponsePage extends GetView {
  API api = Get.put(API());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90.h,
        ),
        Text("Reponse",
            style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: (8 / 100 * 26).sp)),
        SizedBox(
          height: 30.h,
        ),
        Container(
          width: Get.width,
          height: 100.h,
          child: GradientCard(
              gradient: designsGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("url: ${api.baseURL}"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )),
        ),
        FutureBuilder(
         future: api.getTodos(),
         builder: (c, s) {
           if (s.data == null)
             return Text("loading ......");
           else if (s.hasError)
             return Text(" consuming API failed ");
           else
             {
               // s.data is definately a list ... make list tiles.
               List dataList  = s.data as List;
               return Container(
                 height: 500.h,
                 width: Get.width,
                 child: Column(
                   children: dataList.map((e) => make_todo_tile(e["title"],e["completed"])).toList(),
                 ),
               );
             }
         },
            ),
      ],
    );
  }
}
