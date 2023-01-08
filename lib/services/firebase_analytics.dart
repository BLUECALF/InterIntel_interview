import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsService extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
  ///  Firebase EVents
  void broadcastSignUp()
  {
    _analytics.logEvent(name: "sign_up");
  }
  void broadcastPaymentDetailsConfirmation()
  {
    _analytics.logEvent(name: "payment_details_confirmation");
  }
  void broadcastSuccessFetchingConvenienceFee()
  {
    _analytics.logEvent(name: "success_fetching_convenience_fee");
  }
  void broadcastMpesaInput()
  {
    _analytics.logEvent(name: "mpesa_input");
  }
  void broadcastTransactionFailure()
  {
    _analytics.logEvent(name: "transaction_failure");
  }
  void broadcastTransactionSuccess()
  {
    _analytics.logEvent(name: "transaction_success");
  }
}
