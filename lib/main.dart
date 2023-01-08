import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:interintel_interview/pages/splash/LoadingPage.dart';
import 'package:interintel_interview/styles/colors.dart';

import 'utils/HelpfulFunctions.dart';

void main() async {
  // set screen orinetation to potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    print("the wisth is: ${Get.width}");
    print("the height is: ${Get.height}");
    getPermission();
    return  wrapper(childWidget: GetMaterialApp(
      home: LoadingPage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: color_dark_gray, size: 36),
        splashColor: color_blue_dark.withAlpha(50),
        textTheme: TextTheme(),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary:color_blue_dark)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: color_blue_dark,
                onSurface: color_blue_dark,
                side: null //BorderSide(color: Colors.green, width: 1),
            )),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: color_blue_dark,
              backgroundColor: Colors.white,
              onSurface: color_blue_dark,
              side: BorderSide(color: color_blue_dark, width: 1),
            )),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: color_input_decoration,
        ),

      ),
      darkTheme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
          ),
          fontFamily: 'Poppins',
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: color_white, size: 36),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary:color_blue_dark)),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white, primary: color_blue_dark)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: color_blue_dark))),

    ));
  }


}
