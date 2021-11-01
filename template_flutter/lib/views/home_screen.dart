import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common/text_config.dart';
import 'package:template_flutter/view_models/crypto_login_flow/login_bloc/login_bloc.dart';
import 'package:template_flutter/view_models/crypto_login_flow/verify_code_bloc/verify_code_bloc.dart';
import 'package:template_flutter/view_models/notification/firebase_notification_handler.dart';
import 'package:template_flutter/views/checkbox/multi_checkbox_screen.dart';
import 'package:template_flutter/views/crypto_login_flow/login_screen.dart';
import 'package:template_flutter/views/language/change_language.dart';
import 'package:template_flutter/views/map/map_screen.dart';
import 'package:template_flutter/views/notification/notification_screen.dart';
import 'package:template_flutter/views/pin_code/pin_code_dialog.dart';
import 'package:template_flutter/views/pin_code/pin_code_screen.dart';
import 'package:template_flutter/views/progress_state_button/progress_state_button.dart';
import 'package:template_flutter/views/radio%20group/radio_group_demo_screen.dart';
import 'package:template_flutter/views/theme/change_theme.dart';

import 'crypto_login_flow/verify_code_screen.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DemoCategory(),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoCategory extends StatelessWidget {
  const DemoCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.id);
            },
            child: Text(AppLocalizations.of(context)!.notificationScreen)),
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
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RadioGroupDemoScreen.id);
            },
            child: Text("Radio Group Screen")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PinCodeScreen.id);
            },
            child: Text("PinCode Screen")),
        ElevatedButton(
            onPressed: () async => await _openPinCodeDialog(context),
            child: Text("Open PinCode Dialog")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ChangeTheme.id);
            },
            child: Text("Change Theme")),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, ChangeLanguage.id);
          },
          child: Text(
            "Change Language",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => DemoLogin(),
              ),
            );
          },
          child: Text(
            "Login",
          ),
        ),
      ],
    );
  }

  Future _openPinCodeDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => PinCodeDialog(
        title: "Pickup confirmation",
        subtitle: "(Oder ID: AA15)",
        description: "Ask restaurant staff for TAC to complete your pickup",
        pinCodeTextChanged: (val) {},
      ),
    );
  }
}

class DemoLogin extends StatelessWidget {
  const DemoLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginScreen(
        logo: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 86.h, width: 86.h, child: Icon(Icons.error)),
            Flexible(
                child: Text(
              "USDV",
              style: TextConfigs.kText60Bold_4,
            ))
          ],
        ),
        subtitle: "Cross-Border Transactions. Simplified.",
        onForgotPasswordClicked: () {},
        forgotPasswordText: "Forgot password?",
        rememberMeChanged: (bool value) {},
        rememberMeText: "Remember me",

        // primaryColor: Colors.blue,
        // subtitleStyle: TextStyle(color: Colors.orange),
        // textFieldStyle:
        //     TextStyle(fontSize: 20, color: Colors.lightBlueAccent),
        onLoginClicked: (
          String email,
          String password,
          void Function() onSuccess,
          void Function() onFailed,
        ) async {
          await Future.delayed(Duration(seconds: 2));
          onSuccess();
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => DemoVerifyCodeScreen(),
            ),
          );
        },
        // buttonSuccessText: "AAAAAAAAAAAAAAA",
        // buttonSuccessColor: Colors.blue,
      ),
    );
  }
}

class DemoVerifyCodeScreen extends StatelessWidget {
  const DemoVerifyCodeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeBloc(),
      child: VerifyCodeScreen(
        phoneNumber: "0123456789",
        onVerify: (val) async {
          await Future.delayed(Duration(seconds: 2));
          if (val == "123456") return true;
          return false;
        },
        onChanged: (val) {},
        autoVerify: true,
        //primaryColor: Colors.blue,
        // backgroundColor: Colors.red,
        // buttonPrimaryColor: Colors.blue,
        // buttonSecondaryColor: Colors.amber,
        // subtitle2LeftStyle: TextStyle(color: Colors.white),
        // subtitle1: "AAAA",
        // subtitle2RightStyle: TextStyle(color: Colors.white),
        // buttonTextStyle: TextStyle(color: Colors.red),
        // keyboardTextStyle:
        //     TextStyle(color: Colors.white, fontSize: 2342),
        // titleStyle: TextStyle(color: Colors.white),
        // pinTextStyle: TextStyle(color: Colors.white),
        // subtitle1Style: TextStyle(color: Colors.white),
        // title: "ASDASDAS",
        // subtitle2Left: "asdasd",
        // buttonBorderRadius: 2323,
        // subtitle2Right: "QWeqwdsadqw",
        subtitle2Left: "Don’t receive the OTP? ",
        subtitle2Right: "RESEND OTP",
        title: "6-digit code",
        subtitle1: "Please enter the code we’ve sent to ",
      ),
    );
  }
}
