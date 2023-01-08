import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AppController extends GetxController
{
  var nickName = "".obs;
  // user  data
 /*
 {
 "phone":"0712345678",
 "pin":"1234",
  "saveTransactions":true,
  "localAuth":true,
  "nickName":"BLUECALF"
 }
  */

  //register
  //login
  //update
  //getphone
  //getnickname
  //store transaction
  AppController()
  {
    var Box =  GetStorage();
    if(Box.read("user") == null)
      nickName.value = "";
    else
      nickName.value = Box.read("user")["nickName"];

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
    nickName.value = userDetails["nickName"];
  }

  String getPhone()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["phone"] != null ? userDetails["phone"] : "";
  }
  String getNickName()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["nickName"] != null ? userDetails["nickName"] : "";
  }
  String getPIN()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return userDetails["pin"] != null ? userDetails["pin"] : "";
  }
  bool mustAuthenticate()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return (userDetails["localAuth"] != null && userDetails["localAuth"] != false)? true : false;
  }
  bool mustSaveTransaction()
  {
    var Box =  GetStorage();
    Map userDetails = Box.read("user")!=null?Box.read("user"):{};

    return (userDetails["saveTransactions"] != null && userDetails["saveTransactions"] != false)? true : false;
  }
  bool isFirstTime()
  {
    var Box =  GetStorage();
    return Box.read("user") == null ? true:false;
  }
  bool saveTransaction(List timelineState)
  {

   //transactions are stored ina alist of list of map
    //List<List<Map>>
    var Box =  GetStorage();
    List transactionsList = getTransactions();
    // before saving the Stage status need to be made to string
    timelineState[0]["status"] = timelineState[0]["status"].toString();
    timelineState[1]["status"] = timelineState[1]["status"].toString();
    timelineState[2]["status"] = timelineState[2]["status"].toString();

    transactionsList.add(timelineState);
    Box.write("transactionsList", transactionsList);
    return true;
  }
  List getTransactions()
  {
    var Box =  GetStorage();
    List? transactionsListValue = Box.read("transactionsList");
    if(transactionsListValue == null)
    {
      Box.write("transactionsList", []);
      return  Box.read("transactionsList");
    }
    else
      return transactionsListValue;
  }

  int getTotalSpends()
  {
    int totalSpends = 0;
   // get transaction produces a list of lists [[{}],[{}]]
    List allTransactions = getTransactions();
    print("AllTransactions \n\n ${allTransactions}");

    for(int i = 0;i<allTransactions.length;i++)
      {
        if(allTransactions[i][2]["status"] == "StageStatus.SUCCESS")
          {
            /// total spends for this month must
            /// - succeded
            /// - month == todays month
            /// - year == todays year

            var now = new DateTime.now();

            DateTime transactionDate = new DateFormat("dd-MM-yyyy hh:mm:ss").parse(allTransactions[i][2]["time"].toString().replaceAll(".", "-"));

            var monthFormatter = new DateFormat('MM');
            var yearFormatter = new DateFormat('yyyy');
            String todaymonth = monthFormatter.format(now);
            String todayYear = yearFormatter.format(now);
            String tmonth = monthFormatter.format(transactionDate);
            String tYear = yearFormatter.format(transactionDate);

            if(tYear == todayYear && todaymonth == tmonth)
              {
                totalSpends += int.parse(allTransactions[i][2]["amount"]);
              }
            else
              {
                continue;
              }
          }
        else continue;
      }
    return totalSpends;
  }
  int getLastSpendAmount()
  {
    List<int> spendList = [0];
    // get transaction produces a list of lists [[{}],[{}]]
    List allTransactions = getTransactions();
    print("AllTransactions \n\n ${allTransactions}");

    for(int i = 0;i<allTransactions.length;i++)
    {
      if(allTransactions[i][2]["status"] == "StageStatus.SUCCESS")
      {
        spendList.add(int.parse(allTransactions[i][2]["amount"]));
      }
      else continue;
    }
    return spendList[spendList.length > 0 ?spendList.length - 1 : 0];
  }
  String? getLastTransactionDate()
  {
    List<String> successfulTransactionList = ["null"];
    // get transaction produces a list of lists [[{}],[{}]]
    List allTransactions = getTransactions();
    print("AllTransactions \n\n ${allTransactions}");

    for(int i = 0;i<allTransactions.length;i++)
    {
      if(allTransactions[i][2]["status"] == "StageStatus.SUCCESS")
      {
        successfulTransactionList.add(allTransactions[i][2]["time"]);
      }
      else continue;
    }
    return successfulTransactionList[successfulTransactionList.length > 0 ?successfulTransactionList.length - 1 : 0];
  }

}
