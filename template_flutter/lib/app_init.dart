import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter/services/services_api.dart';
import 'package:template_flutter/views/home_screen.dart';
import 'package:template_flutter/views/splash_screen.dart';

import 'common/config.dart';
import 'common/constants/general.dart';
import 'view_models/app_model.dart';

class AppInit extends StatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> with AfterLayoutMixin {
  final StreamController<bool> _streamInit = StreamController<bool>();

  bool isFirstSeen = true;
  bool isLoggedIn = false;

  /// check if the screen is already seen At the first time
  Future<bool> checkFirstSeen(SharedPreferences prefs) async {
    /// Ignore if OnBoardOnlyShowFirstTime is set to true.
    if (kAdvanceConfig['OnBoardOnlyShowFirstTime'] == false) {
      return false;
    }

    bool _seen = prefs.getBool('seen') ?? false;
    return _seen;
  }

  /// Check if the App is Login
  Future checkLogin(SharedPreferences prefs) async {
    return prefs.getBool('loggedIn') ?? false;
  }

  Future loadInitData() async {
    try {
      printLog("[AppState] Inital Data");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isFirstSeen = await checkFirstSeen(prefs);
      setState(() {});
      isLoggedIn = await checkLogin(prefs);
      /// Load App model config
      APIServices().setAppConfig(serverConfig);

      printLog("[AppState] Init Data Finish");
    } catch (e, trace) {
      printLog(e.toString());
      printLog(trace.toString());
    }
    if (!_streamInit.isClosed) {
      _streamInit.add(isFirstSeen);
    }
  }


  @override
  void initState() {
    loadInitData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamInit.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _streamInit.stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          // if(!snapshot.data!){
          //   return HomeScreen();
          // }
          return SplashScreen();
        });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(1080, 1920),
    );
  }
}
