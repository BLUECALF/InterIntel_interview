import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController
{
  var name = "".obs;
  var phone = "".obs;
  var email = "".obs;
  var saveMe = false.obs;

  // user data
  //
  AppController()
  {
    var Box =  GetStorage();
    if(Box.read("user") == null)
      name.value = "";
    else {
      name.value = Box.read("user")["name"];
      phone.value = Box.read("user")["phone"];
      email.value = Box.read("user")["email"];
      saveMe.value = Box.read("user")["saveMe"];
    }

  }


  Future<void > initMixpanel() async {
   var mixtoken = "76b081e8a759d7b8782ef9eefdd6ebd8";

   // var testmixtoken = "e7568421b7cc33769a1b24a17516ed2c";

  }

  void register(Map userDetails)
  {
    var Box =  GetStorage();
    // save users details
    Box.write("user", userDetails);
  }
  void update_details_in_state(Map userDetails)
  {
    name.value = userDetails["name"];
    phone.value = userDetails["phone"];
    email.value = userDetails["email"];
    saveMe.value = userDetails["saveMe"];
  }


  String getPhone()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["phone"] != null ? userDetails["phone"] : "";
  }
  String getName()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["name"] != null ? userDetails["name"] : "";
  }
  String getEmail()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["email"] != null ? userDetails["email"] : "";
  }
  bool saveDetails()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return (userDetails["saveMe"] != null && userDetails["saveMe"] != false)? true : false;
  }
  bool isFirstTime()
  {
    var Box =  GetStorage();
    return Box.read("user") == null ? true:false;
  }
}
