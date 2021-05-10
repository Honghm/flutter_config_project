import 'package:flutter/material.dart';

class ProgressButtonAnimation extends StatefulWidget {
  final Function? onTap;
  final String? titleButton;
  final String? titleButtonSuccess;
  final String? titleButtonFail;
  final Color? color;
  final Color? colorSuccess;
  final Color? colorFail;
  final Widget? icon;
  final Widget? iconSuccess;
  final Widget? iconFail;

  ProgressButtonAnimation({
    Key? key,
    this.onTap,
    this.color,
    this.colorSuccess,
    this.colorFail,
    this.titleButton = "Sign In",
    this.titleButtonSuccess,
    this.titleButtonFail,
    this.icon,
    this.iconFail,
    this.iconSuccess,
  }) : super(key: key);

  @override
  _ProgressButtonAnimationState createState() =>
      _ProgressButtonAnimationState();
}

class _ProgressButtonAnimationState extends State<ProgressButtonAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController buttonController;
  late final Animation<EdgeInsets> containerCircleAnimation;
  late final Animation buttonSqueezeAnimation;


  Future? _playAnimation() async {
    try {
      await buttonController.forward();
      Future.delayed(Duration(milliseconds: 100),(){
        _stopAnimation();
      });
    } on TickerCanceled {
      print("[_playAnimation] error");
    }
  }

  Future? _stopAnimation() async {
    try {
      await buttonController.reverse();
      buttonController.dispose();
    } on TickerCanceled {
      print("[_stopAnimation] error");
    }
  }
  Widget _buildAnimation(BuildContext? context, Widget? child) {
    return GestureDetector(
      onTap: () {
        _playAnimation();
        if(widget.onTap!=null){
          widget.onTap!();
        }
      },
      child: Container(
        width: buttonSqueezeAnimation.value,
        height: 50,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        child: buttonSqueezeAnimation.value > 75.0
            ? Text(
                widget.titleButton!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              )
            : const CircularProgressIndicator(
                value: null,
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    containerCircleAnimation = EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 30.0),
      end: const EdgeInsets.only(bottom: 0.0),
    ).animate(
      CurvedAnimation(
        parent: buttonController,
        curve: const Interval(
          0.500,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
