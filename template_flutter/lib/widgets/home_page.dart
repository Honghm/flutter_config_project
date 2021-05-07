import 'dart:math';

import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/reacted/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _widgetId = 1;

  Widget _renderWidget1() {
    return Container(
      key: Key('first'),
      width: 50,
      height: 50,
      child: Image.asset(
        "assets/icons/sad_color.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _renderWidget2() {
    return Container(
        key: Key('second'),
        width: 50,
        height: 50,
        child: Image.asset(
          "assets/icons/sad.png",
          fit: BoxFit.fill,
        ));
  }

  Widget _renderWidget() {
    return _widgetId == 1 ? _renderWidget1() : _renderWidget2();
  }

  _updateWidget() {
    setState(() {
      _widgetId = _widgetId == 1 ? 2 : 1;
    });
  }


  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 500),
    );
    animationController.value = 1;
    animation = Tween(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     _updateWidget();
            //   },
            //   child: AnimatedSwitcher(
            //     duration: const Duration(milliseconds: 300),
            //     transitionBuilder: (Widget child, Animation<double> animation) {
            //       return ScaleTransition(scale: animation, child: child);
            //     },
            //     child: _renderWidget(),
            //   ),
            // ),
           LikeButton(

           )
          ],
        ),
      ),
    );
  }
}
