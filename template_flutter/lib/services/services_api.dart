

import 'package:dio/dio.dart';

import 'config.dart';

class APIServices{
  static final APIServices _instance = APIServices._internal();

  APIServices._internal();
  late String url;
  factory APIServices() => _instance;
  Dio dio = new Dio();
  void setAppConfig(appConfig) {
    ConfigServices().setConfig(appConfig);
    url = appConfig["url"];
  }


  Future<void> sendNotification() async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAkNZ_-y8:APA91bF_-kRFCNbgNe7SeIxTzaz6ePRJzYa6R2l-gxivuaHg0x1Tb5Cod61eymeCAJuGLLFNP0RKzZwfFL1AmBK-4JrtDpn6TswllPX3nrIzxmmFi-INljqOESmiB6Dd-n0F9dp9gIK7'
    };
   await dio.post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "to": "dIjxXbtVRG2AH5AW8MBi90:APA91bFQrBA5ldU04L-smbarYxYd4hE0-jRZM6rmp9pC-UZkcj9IZ4e3CwwdCMX9sQI8TjueKS_oR0QllNEoCyE1T3iqg_weqNC8gM7hmV-yuIME5xi4DQHzu7P-0HPvHJvbJb9w35SF",
        "notification": {
          "title": "This is a test title",
          "body": "OK HELLO"
        },
        "data": {
          "title": "This is a test title",
          "body": "OK HELLO"
        }
      },
    );
  }
}