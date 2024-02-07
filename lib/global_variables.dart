// Add stream controller
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

// for passing messages from event handler to the UI
final messageStreamController = BehaviorSubject<RemoteMessage>();
