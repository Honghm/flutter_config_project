import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter/common/constants/general.dart';
class AppModel with ChangeNotifier{
  String locale = kAdvanceConfig['DefaultLanguage'].toString();
  bool darkTheme = false;
  bool isInit = false;
  Map<String, dynamic> appConfig = {};
  AppModel() {
    getConfig();
  }
  Future<bool> getConfig() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = prefs.getString("language") ?? kAdvanceConfig['DefaultLanguage'].toString();
      darkTheme = prefs.getBool("darkTheme") ?? false;
      isInit = true;
      return true;
    } catch (err) {
      return false;
    }
  }
  Future<bool> changeLanguage(String country, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = country;
      await prefs.setString("language", country);

     notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }
  Future<void> updateTheme(bool theme) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      darkTheme = theme;
      await prefs.setBool("darkTheme", theme);
      notifyListeners();
    } catch (error) {
      printLog('[_getFacebookLink] error: ${error.toString()}');
    }
  }

}