import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interintel_interview/controllers/CommonPageController.dart';
import 'package:interintel_interview/styles/colors.dart';

class TabBarMaterialWidget extends GetView {
  CommonPageController commonPageController = Get.find<CommonPageController>();
  PageController _pageController = Get.find<PageController>();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Obx(()=> ClipPath(
        clipper: MyCliper(),
        child: Container(
          decoration: BoxDecoration(
            color: color_blue_dark,
                borderRadius: BorderRadius.all(Radius.circular(20.sp))
          ),
          height: 98.sp,
          width: 428.sp,
          child: Column(
            children: [
              SizedBox(height: 10.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildTabItem(0, Icons.info,"info"),
                  BuildTabItem(0, Icons.card_membership,"design"),
                  //BuildTabItemPNG(1, "assets/images/send_money.png","Send"),
                  BuildTabItem(2,Icons.api,"response"),
                  BuildTabItem(2,Icons.book,"dictionary"),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget BuildTabItem(int index,IconData icondata,String label)
  {
    if(commonPageController.selected_index.value == index)
      {
        //you have been selected
        return TextButton(
          onPressed: (){
            commonPageController.selected_index.value = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
          },
          child: Container(
            height: 63.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icondata,color: color_white,size: 35.sp,),
                Text(label,
                  style: TextStyle(
                      color: color_white,
                      fontSize: 12.sp
                  ),
                )
              ],
            ),
          ),
        );
      }
    else
      {
       return TextButton(
          onPressed: (){
            commonPageController.selected_index.value = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
          },
          child: Container(
            height: 63.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icondata,color: color_gray_light_middle,size: 35.sp,),
                Text(label,
                  style: TextStyle(
                      color: color_gray_light_middle,
                      fontSize: 12.sp
                  ),
                )
              ],
            ),
          ),
        );
      }
  }
  Widget BuildTabItemPNG(int index,String path,String label)
  {
    if(commonPageController.selected_index.value == index)
      {
        //you have been selected
        return TextButton(
          onPressed: (){
            commonPageController.selected_index.value = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
          },
          child: Container(
            height: 63.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 35.sp,
                    height: 35.sp,
                    child: Image.asset(path,color: color_white)),
                Text(label,
                  style: TextStyle(
                      color: color_white,
                      fontSize: 12.sp
                  ),
                )
              ],
            ),
          ),
        );
      }
    else
      {
       return TextButton(
          onPressed: (){
            commonPageController.selected_index.value = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInExpo);
          },
          child: Container(
            height: 63.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35.sp,
                    height: 35.sp,
                    child: Image.asset(path,color: color_gray_light_middle)),
                Text(label,
                  style: TextStyle(
                      color: color_gray_light_middle,
                      fontSize: 12.sp
                  ),
                )
              ],
            ),
          ),
        );
      }
  }
}

class MyCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width*0.0490654,size.height*0.0900000);
    path0.cubicTo(size.width*0.1507009,size.height*0.1075000,size.width*0.7184579,size.height*0.0975000,size.width*0.9415888,size.height*0.1000000);
    path0.cubicTo(size.width*0.9707944,size.height*0.3550000,size.width*0.9661215,size.height*0.6750000,size.width*0.9462617,size.height*0.9200000);
    path0.cubicTo(size.width*0.7184579,size.height*0.9250000,size.width*0.2698598,size.height*0.9150000,size.width*0.0420561,size.height*0.9200000);
    path0.cubicTo(size.width*0.0128505,size.height*0.6675000,size.width*0.0128505,size.height*0.3375000,size.width*0.0490654,size.height*0.0900000);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return true;
  }
}