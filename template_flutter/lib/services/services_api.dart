

import 'config.dart';

class APIServices{
  static final APIServices _instance = APIServices._internal();

  APIServices._internal();
  late String url;
  factory APIServices() => _instance;

  void setAppConfig(appConfig) {
    ConfigServices().setConfig(appConfig);
    url = appConfig["url"];
  }
}