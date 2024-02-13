import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseSubscriptionManager {
  static const String lastRefreshKey = "last_refresh_timestamp";
  static const int monthInMillis =
      30 * 24 * 60 * 60 * 1000; // Assuming 30 days in a month

  final FirebaseMessaging _firebaseMessaging;
  final SharedPreferences _prefs;

  FirebaseSubscriptionManager(this._firebaseMessaging, this._prefs);

  Future<void> refreshSubscriptionIfNeeded() async {
    int lastRefreshTimestamp = _prefs.getInt(lastRefreshKey) ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (lastRefreshTimestamp == 0 ||
        currentTime - lastRefreshTimestamp >= monthInMillis) {
      // It's time to refresh the subscription
      await subscribeToFirebaseTopic();
      await _prefs.setInt(lastRefreshKey, currentTime);
    }
  }

  Future<void> subscribeToFirebaseTopic() async {
    // Subscribe to 'news' topic
    await _firebaseMessaging.subscribeToTopic("news");
  }
}
