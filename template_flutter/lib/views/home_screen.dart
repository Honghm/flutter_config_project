import 'package:flutter/material.dart';
import 'package:template_flutter/view_models/notification/firebase_notification_handler.dart';
import 'package:template_flutter/views/checkbox/multi_checkbox_screen.dart';
import 'package:template_flutter/views/map/map_screen.dart';
import 'package:template_flutter/views/notification/notification_screen.dart';
import 'package:template_flutter/views/progress_state_button/progress_state_button.dart';

import 'gallery_view/gallery_view_screen.dart';
import 'image_slider/image_slider.dart';

class HomeScreen extends StatefulWidget {
  static final id = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseNotification firebaseNotification = FirebaseNotification();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      firebaseNotification.setupFirebase(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, NotificationScreen.id);
                },
                child: Text("Notification Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, GalleryViewScreen.id);
                },
                child: Text("Gallery Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MapScreen.id);
                },
                child: Text("Real Time Map Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProgressStateButtonScreen.id);
                },
                child: Text("Progress State Button Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ImageSlider.id);
                },
                child: Text("Image Slider Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MultiCheckboxScreen.id);
                },
                child: Text("MultiCheckbox Screen")),
          ],
        ),
      ),
    );
  }
}
