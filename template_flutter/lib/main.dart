import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'common/constants/general.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  printLog('[main] ============== main.dart START ==============');

  /// enable network traffic logging
  HttpClient.enableTimelineLogging = false;
  runZoned(() {
    runApp(App());
  });
}