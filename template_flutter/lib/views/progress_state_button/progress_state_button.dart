import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

class ProgressStateButtonScreen extends StatefulWidget {
  static final id = 'ProgressStateButtonScreen';
  const ProgressStateButtonScreen({Key? key}) : super(key: key);

  @override
  _ProgressStateButtonScreenState createState() =>
      _ProgressStateButtonScreenState();
}

class _ProgressStateButtonScreenState extends State<ProgressStateButtonScreen> {
  ButtonState state = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: ProgressButton(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            radius: 20.0,
            state: state,
            stateWidgets: {
              ButtonState.idle: Text(
                "Idle",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              ButtonState.loading: Text(
                "Loading",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              ButtonState.fail: Text(
                "Fail",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              ButtonState.success: Text(
                "Success",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )
            },
            stateColors: {
              ButtonState.idle: Colors.grey.shade400,
              ButtonState.loading: Colors.blue.shade300,
              ButtonState.fail: Colors.red.shade300,
              ButtonState.success: Colors.green.shade400,
            },
            onPressed: onPressedCustomButton,
          ),
        ),
      ),
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (state) {
        case ButtonState.idle:
          state = ButtonState.loading;
          break;
        case ButtonState.loading:
          state = ButtonState.fail;
          break;
        case ButtonState.success:
          state = ButtonState.idle;
          break;
        case ButtonState.fail:
          state = ButtonState.success;
          break;
      }
    });
  }
}
