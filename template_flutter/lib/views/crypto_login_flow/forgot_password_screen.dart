import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:template_flutter/common/color_config.dart';
import 'package:template_flutter/common/text_config.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({
    Key? key,
    this.subtitle,
    this.subtitleStyle,
    this.logo,
    this.backgroundColor,
    this.backIcon,
    this.buttonIdleText,
    this.buttonErrorText,
    this.buttonSuccessText,
    this.buttonErrorColor,
    this.buttonSuccessColor,
    this.buttonTextStyle,
    this.primaryColor,
    this.emailMessage,
    this.textFieldDecoration,
    this.title,
    required this.onContinueClicked,
  }) : super(key: key);
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? logo;
  final Color? backgroundColor;
  final Widget? backIcon;
  final String? buttonIdleText;
  final String? buttonErrorText;
  final String? buttonSuccessText;
  final Color? buttonErrorColor;
  final Color? buttonSuccessColor;
  final TextStyle? buttonTextStyle;
  final Color? primaryColor;
  final Text? emailMessage;
  final InputDecoration? textFieldDecoration;
  final Text? title;
  final Future<bool> Function(String email) onContinueClicked;

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _email = TextEditingController();

  TextStyle get buttonTextStyle =>
      widget.buttonTextStyle ?? TextConfigs.kTextConfig;
  final _formKey = GlobalKey<FormState>();

  final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConfigs.kColor1,
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
        child: Padding(
          padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 100.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (widget.logo != null) widget.logo!,
                SizedBox(
                  height: 32.h,
                ),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: widget.subtitleStyle ?? TextConfigs.kText40Normal_2,
                  ),
                SizedBox(
                  height: 56.h,
                ),
                widget.title ??
                    Text(
                      "Forgot your password?",
                      style: TextConfigs.kText45Bold_9,
                      textAlign: TextAlign.center,
                    ),
                SizedBox(
                  height: 52.h,
                ),
                TextFormField(
                  controller: _email,
                  style: TextConfigs.kText40Normal_2,
                  cursorColor: ColorConfigs.kColor6,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || emailReg.hasMatch(val)) return null;
                    return "Invalid Email";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: widget.textFieldDecoration ??
                      InputDecoration(
                        contentPadding: EdgeInsets.all(32.h),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConfigs.kColor6)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConfigs.kColor7)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorConfigs.kColor5)),
                        hintStyle: TextConfigs.kText40Normal_8,
                        hintText: "Email",
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 52.h, bottom: 150.h),
                  child: widget.emailMessage ??
                      Text(
                        "Enter the email address you used to sign in to Heineken to reset your password.",
                        style: TextConfigs.kText30Normal_10,
                      ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ProgressButtonAnimation(
                    height: 120.h,
                    maxWidth: _size.width,
                    state: stateOnlyText,
                    onPressed: _listenStateButton,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        widget.buttonIdleText ?? "Continue",
                        style: buttonTextStyle,
                      ),
                      ButtonStatus.fail: Text(
                        widget.buttonErrorText ?? "Có lỗi xảy ra",
                        style: buttonTextStyle,
                      ),
                      ButtonStatus.success: Text(
                        widget.buttonSuccessText ?? "Continue",
                        style: buttonTextStyle,
                      ),
                    },
                    stateColors: {
                      ButtonStatus.idle:
                          widget.primaryColor ?? ColorConfigs.kColor4,
                      ButtonStatus.loading:
                          widget.primaryColor ?? ColorConfigs.kColor4,
                      ButtonStatus.fail:
                          widget.buttonErrorColor ?? ColorConfigs.kColor5,
                      ButtonStatus.success:
                          widget.buttonSuccessColor ?? ColorConfigs.kColor4,
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStatus stateOnlyText = ButtonStatus.idle;

  _listenStateButton() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    if (await widget.onContinueClicked(_email.text)) {
      setState(() {
        stateOnlyText = ButtonStatus.success;
      });
      Navigator.pop(context, true);
    } else {
      setState(() {
        stateOnlyText = ButtonStatus.fail;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        stateOnlyText = ButtonStatus.idle;
      });
    }
  }
}
