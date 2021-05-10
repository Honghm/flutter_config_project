import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/view_models/notification/firebase_notification_handler.dart';

import 'app.dart';
import 'common/constants/general.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  printLog('[main] ============== main.dart START ==============');
await Firebase.initializeApp();
FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  /// enable network traffic logging
  HttpClient.enableTimelineLogging = false;
  runZoned(() {
    runApp(App());
  });
}

Future<void> _backgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  print("Handle background service $message");
  dynamic data = message.data["data"];
  FirebaseNotification.showNotification(data["title"], data["body"]);
}
