import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/button/progress_button_animation.dart';
class ExProgressButtonAnimation extends StatefulWidget {
  const ExProgressButtonAnimation({Key? key}) : super(key: key);

  @override
  _ExProgressButtonAnimationState createState() => _ExProgressButtonAnimationState();
}

class _ExProgressButtonAnimationState extends State<ExProgressButtonAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController( duration: const Duration(milliseconds: 3000), vsync: this);
  }
  Future? _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
      Future.delayed(Duration(milliseconds: 100),(){
        _stopAnimation();
      });
    } on TickerCanceled {
      print("[_playAnimation] error");
    }
  }

  Future? _stopAnimation() async {
    try {
      await _loginButtonController.reverse();

      setState(() {
        isLoading = false;
      });
      _loginButtonController.dispose();
    } on TickerCanceled {
      print("[_stopAnimation] error");
    }
  }
  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ProgressButtonAnimation(
    );
  }
}
