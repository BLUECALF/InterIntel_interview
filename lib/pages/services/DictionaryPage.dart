import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:interintel_interview/styles/colors.dart';

class DictionaryPage extends GetView {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map rawMap = {
      '34': 'thirty-four',
      '90': 'ninety',
      '91': 'ninety-one',
      '21': 'twenty-one',
      '61': 'sixty-one',
      '9': 'nine',
      '2': 'two',
      '6': 'six',
      '3': 'three',
      '8': 'eight',
      '80': 'eighty',
      '81': 'eighty-one',
      'Ninety-Nine': '99',
      'nine-hundred': '900'
    };
    return Column(
      children: [
        SizedBox(height: 40.h,),
        Text("Dictionary",
            style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: (8 / 100 * 26).sp)),
        SizedBox(height: 40.h,),
        Container(
          width: Get.width,
          child: GradientCard(
              gradient: designsGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sortMap(rawMap).keys.map((e) => Text(e)).toList(),
              )),
        ),
      ],
    );
  }
  Map sortMap(Map rawMap)
  {
    var sortedByValueMap = Map.fromEntries(
        rawMap.entries.toList()..sort((e1, e2) => findNumber(e1).compareTo(findNumber(e2))));
    return sortedByValueMap;
  }
  int findNumber(MapEntry e)
  {
    try
    {
      // convert key to int
      return int.parse(e.key);
    } catch(error)
    {
      // if a failure occurs converting key to int ... meains its numbers are in the value side
      return int.parse(e.value);
    }
  }
}
