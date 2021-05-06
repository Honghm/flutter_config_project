import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;
  startTime() async {
    var _duration = const Duration(seconds: 3);

    return Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 5));
    animation =
        CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    animation!.addListener(() => setState(() {}));
    _controller!.forward();

    startTime();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

        ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: animation!.value * 250,
                  height: animation!.value * 250,
                  color: Colors.pink,
                  alignment: Alignment.center,
                  child: Text("YOUR LOGO"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
