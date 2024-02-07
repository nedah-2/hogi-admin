import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hogi_milk_admin/global_variables.dart';
import 'package:hogi_milk_admin/screens/sign_in.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Request permission
  final messaging = FirebaseMessaging.instance;

  // Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    messageStreamController.sink.add(message);
  });

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // subscribe to a topic.
  const topic = 'news';
  await messaging.subscribeToTopic(topic);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SignInScreen(),
    );
  }
}
