import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class PrivPayAnimatedIcon extends StatefulWidget {
  String jsonPath = "";
  double size;

  ///constructor
  PrivPayAnimatedIcon({required this.jsonPath, required this.size}) {}

  @override
  State<PrivPayAnimatedIcon> createState() =>
      _PrivPayAnimatedIconState(jsonPath: jsonPath,size: size);
}

class _PrivPayAnimatedIconState extends State<PrivPayAnimatedIcon>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  String jsonPath = "";
  double size;

  _PrivPayAnimatedIconState({required this.jsonPath,required this.size}) {}

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(jsonPath,
        width: size.w,
        height: size.h,
        fit: BoxFit.contain,
        repeat: false,
        controller: animationController,
        onLoaded: (composition) {
      animationController.forward();
        });
  }
}
