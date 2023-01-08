import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interintel_interview/controllers/AppController.dart';
import 'package:interintel_interview/controllers/CommonPageController.dart';
import 'package:interintel_interview/widgets/tab_bar_material_widget.dart';

import '../utils/HelpfulFunctions.dart';
import 'services/SendPage.dart';

class CommonPage extends GetView {
  /// puting main constant controllers
  final _commonPageController =
      Get.lazyPut(() => CommonPageController(), fenix: true);
  final _pageController =
      Get.lazyPut(() => PageController(initialPage: 0), fenix: true);

  //final _appController = Get.lazyPut(() =>AppController(),fenix: true);
  final CommonPageController commonPageController =
      Get.find<CommonPageController>();
  final AppController appController = Get.put(AppController());
  final PageController pageController = Get.find<PageController>();

  var update_clicked = false.obs;

  @override
  Widget build(BuildContext context) {
    checkNetwork(context);
    return wrapper(
      childWidget: Stack(
        children: [
     Scaffold(
              body: PageView(
                controller: pageController,
                onPageChanged: (newIndex) {
                  commonPageController.selected_index.value = newIndex;
                },
                children: [
                  DashboardPage(),
                  //ContactsPage(),
                  SendPage(),
                  AccountPage(),
                ],
              ),
              bottomNavigationBar: TabBarMaterialWidget(),
            ),
        ],
      ),
    );
  }

  bool changeUpdateClicked() {
    update_clicked.value = !update_clicked.value;
    print(
        "The Value of installed version is ::${Get.find<Upgrader>().currentInstalledVersion()}");
    Get.defaultDialog(
        title: "Update App and Restart",
        content: Text("Restart to continue"),
        onConfirm: (){},
        barrierDismissible: false);
    return true;
  }
  void checkNetwork(context) async
  {
    if(await hasInternet() == false)
      {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.all(10.0),
                title: Text('You have no Internet'),
                content: Text('Connect to an internet connection via data or WIFI,Then restart the PrivPay app to continue !'),
              ),
            );
          },
        );
      }
  }
}
