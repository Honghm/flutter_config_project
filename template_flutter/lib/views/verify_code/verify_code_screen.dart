import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:template_flutter/common/color_config.dart';
import 'package:template_flutter/common/text_config.dart';

class VerifyCodeScreen extends StatefulWidget {
  static const id = "VerifyCodeScreen";
  final String? phoneNumber;
  final String? email;
  final String? title;
  final String? subtitle1;
  final String? subtitle2Left;
  final String? subtitle2Right;
  final TextStyle? titleStyle;
  final TextStyle? subtitle1Style;
  final TextStyle? subtitle2LeftStyle;
  final TextStyle? subtitle2RightStyle;
  final PinTheme? pinTheme;
  final TextStyle? pinTextStyle;
  final bool obscureText;
  final TextStyle? keyboardTextStyle;
  final Color? buttonPrimaryColor;
  final Color? buttonSecondaryColor;
  final TextStyle? buttonTextStyle;
  final double? buttonBorderRadius;
  final Widget? backIcon;
  final int length;
  final ValueChanged<String> onChanged;
  final bool autoVerify;
  final Future<bool> Function(String) onVerify;
  final GestureTapCallback? onSubtitle2RightTap;
  final Color? backgroundColor;

  const VerifyCodeScreen({
    Key? key,
    this.phoneNumber,
    this.email,
    this.title,
    this.subtitle1,
    this.subtitle2Left,
    this.titleStyle,
    this.subtitle1Style,
    this.subtitle2LeftStyle,
    this.subtitle2RightStyle,
    this.subtitle2Right,
    this.pinTheme,
    this.pinTextStyle,
    this.obscureText = false,
    this.keyboardTextStyle,
    this.buttonPrimaryColor,
    this.buttonSecondaryColor,
    this.buttonTextStyle,
    this.buttonBorderRadius,
    this.backIcon,
    this.length = 6,
    required this.onChanged,
    this.autoVerify = true,
    required this.onVerify,
    this.onSubtitle2RightTap,
    this.backgroundColor,
  })  : assert(length % 2 == 0),
        super(key: key);

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> errorController;
  ButtonStatus stateOnlyText = ButtonStatus.idle;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  _wrongPinCode() {
    setState(() {
      stateOnlyText = ButtonStatus.fail;
    });
    errorController.add(ErrorAnimationType.shake);
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        codeController.clear();
      });
    });
  }

  _onVerify() async {
    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    if (await widget.onVerify(codeController.text)) {
      setState(() {
        stateOnlyText = ButtonStatus.success;
      });
    } else {
      _wrongPinCode();
    }
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        stateOnlyText = ButtonStatus.idle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? ColorConfigs.kColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.backgroundColor ?? ColorConfigs.kColor1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: widget.backIcon ??
              Icon(
                Icons.arrow_back_ios,
                color: ColorConfigs.kColor2,
              ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(widget.title ?? "6-digit code",
                            style:
                                widget.titleStyle ?? TextConfigs.kText80Bold_2),
                      ),
                      SizedBox(height: 28.h),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.subtitle1 ??
                                    "Please enter the code we’ve sent to ",
                                style: widget.subtitle1Style ??
                                    TextConfigs.kText35Normal_3,
                              ),
                              TextSpan(
                                text: "${widget.phoneNumber ?? widget.email}",
                                style: widget.subtitle1Style ??
                                    TextConfigs.kText35Normal_3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 75.h),
                      Container(
                        height: 130.h,
                        padding: EdgeInsets.symmetric(horizontal: 100.w),
                        child: PinCodeTextField(
                          textStyle: TextStyle(color: ColorConfigs.kColor2),
                          length: widget.length,
                          controller: codeController,
                          showKeyboard: false,
                          appContext: context,
                          errorAnimationController: errorController,
                          symbolPosition: widget.length ~/ 2 - 1,
                          obscureText: widget.obscureText,
                          symbol: Container(
                            alignment: Alignment.center,
                            child: Container(
                              height: 2.h,
                              width: 25.w,
                              color: widget.pinTheme?.inactiveColor ??
                                  ColorConfigs.kColor3,
                              margin: EdgeInsets.only(left: 30.w),
                            ),
                          ),
                          onChanged: widget.onChanged,
                          onCompleted: (val) async {
                            if (!widget.autoVerify) return;
                            _onVerify();
                          },
                          pinTheme: widget.pinTheme ??
                              PinTheme(
                                fieldHeight: 120.h,
                                fieldWidth: 100.w,
                                borderWidth: 1,
                                activeColor: widget.buttonPrimaryColor ??
                                    ColorConfigs.kColor4,
                                inactiveColor: ColorConfigs.kColor3,
                                shape: PinCodeFieldShape.box,
                              ),
                        ),
                      ),
                      SizedBox(height: 75.h),
                      Container(
                          child: Row(
                        children: [
                          Text(
                            widget.subtitle2Left ?? "Don’t receive the OTP? ",
                            style: widget.subtitle2LeftStyle ??
                                TextConfigs.kText40Normal_2,
                          ),
                          InkWell(
                            onTap: widget.onSubtitle2RightTap,
                            child: Text(
                              widget.subtitle2Right ?? "RESEND OTP",
                              style: widget.subtitle2RightStyle ??
                                  TextConfigs.kText40Normal_4,
                            ),
                          )
                        ],
                      )),
                      SizedBox(height: 240.h),
                      Container(
                        alignment: Alignment.center,
                        child: ProgressButtonAnimation(
                          height: 120.h,
                          maxWidth: _size.width,
                          state: stateOnlyText,
                          onPressed: () async {
                            if (widget.autoVerify ||
                                codeController.text.length < widget.length)
                              return;
                            setState(() {
                              stateOnlyText = ButtonStatus.loading;
                            });
                            _onVerify();
                          },
                          radius: widget.buttonBorderRadius ?? 100,
                          stateWidgets: {
                            ButtonStatus.idle: Text(
                                "VERIFY ${widget.phoneNumber == null ? "EMAIL" : "PHONE"}",
                                style: widget.buttonTextStyle ??
                                    TextConfigs.kTextConfig),
                            ButtonStatus.fail: Text("Có lỗi xảy ra",
                                style: widget.buttonTextStyle ??
                                    TextConfigs.kTextConfig),
                            ButtonStatus.success: Text("VERIFY EMAIL",
                                style: widget.buttonTextStyle ??
                                    TextConfigs.kTextConfig),
                          },
                          stateColors: {
                            ButtonStatus.idle: widget.buttonPrimaryColor ??
                                ColorConfigs.kColor4,
                            ButtonStatus.loading: widget.buttonPrimaryColor ??
                                ColorConfigs.kColor4,
                            ButtonStatus.fail: widget.buttonSecondaryColor ??
                                ColorConfigs.kColor5,
                            ButtonStatus.success: widget.buttonPrimaryColor ??
                                ColorConfigs.kColor4,
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 20.h),
                        color: Color(0xFFD1D5DB),
                        child: Keyboard(
                          onKeyboardTap: _onKeyboardTap,
                          textStyle: widget.keyboardTextStyle ??
                              TextConfigs.kText72Bold_2,
                          numHeight: 133.h,
                          numWidth: _size.width / 3 - 40.w,
                          rightButtonFn: () {
                            if (codeController.text.length > 0) {
                              setState(() {
                                codeController.text = codeController.text
                                    .substring(
                                        0, codeController.text.length - 1);
                              });
                            }
                          },
                          rightIcon: Icon(
                            Icons.backspace_outlined,
                            color: ColorConfigs.kColor2,
                          ),
                          style: KeyboardStyle.STYLE1,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      codeController.text = codeController.text + value;
    });
  }
}
