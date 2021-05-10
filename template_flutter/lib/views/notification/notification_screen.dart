import 'package:flutter/material.dart';
import 'package:template_flutter/services/services_api.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Firebase Cloud Messaging"),
            InkWell(
              onTap: (){
                APIServices().sendNotification();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text("Send notification"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

