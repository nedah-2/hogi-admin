import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hogi_milk_admin/providers/auth_manager.dart';
import 'package:hogi_milk_admin/providers/option_manager.dart';
import 'package:hogi_milk_admin/providers/order_manager.dart';
import 'package:hogi_milk_admin/providers/promote_provider.dart';
import 'package:hogi_milk_admin/screens/authentication_screen.dart';
import 'package:hogi_milk_admin/utils/global_scafflold.dart';
import 'package:hogi_milk_admin/utils/topic_subscription.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // subscribe to a topic.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseSubscriptionManager subscriptionManager =
      FirebaseSubscriptionManager(firebaseMessaging, prefs);
  await subscriptionManager.refreshSubscriptionIfNeeded();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthManager()),
        ChangeNotifierProvider(create: (_) => OptionManager()),
        ChangeNotifierProvider(create: (_) => OrderManager()),
        ChangeNotifierProvider(create: (_) => PromoteProvider()),
        // Add more providers as needed
      ],
      child: MaterialApp(
        title: 'HOGI Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        scaffoldMessengerKey: MySnackBar.scaffoldMessengerKey,
        home: const AuthenticationScreen(),
      ),
    );
  }
}
