import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:template_flutter/common/color_config.dart';
import 'package:template_flutter/common/text_config.dart';
import 'package:template_flutter/view_models/crypto_login_flow/verify_code_bloc/verify_code_bloc.dart';

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
  final Color? buttonErrorColor;
  final Color? buttonSuccessColor;
  final TextStyle? buttonTextStyle;
  final Widget? backIcon;
  final int length;
  final ValueChanged<String> onChanged;
  final bool autoVerify;
  final Future<bool> Function(String) onVerify;
  final GestureTapCallback? onSubtitle2RightTap;
  final Color? backgroundColor;
  final String? buttonIdleText;
  final String? buttonErrorText;
  final String? buttonSuccessText;
  final Color? primaryColor;
  final bool disableCenterLine;

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
    this.buttonErrorColor,
    this.buttonTextStyle,
    this.backIcon,
    this.length = 6,
    required this.onChanged,
    this.autoVerify = true,
    required this.onVerify,
    this.onSubtitle2RightTap,
    this.backgroundColor,
    this.buttonIdleText,
    this.buttonErrorText,
    this.buttonSuccessText,
    this.buttonSuccessColor,
    this.primaryColor,
    this.disableCenterLine = false,
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
  VerifyCodeBloc? _bloc;

  @override
  void didChangeDependencies() {
    errorController = StreamController<ErrorAnimationType>();
    _bloc = BlocProvider.of<VerifyCodeBloc>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocListener<VerifyCodeBloc, VerifyCodeState>(
      listener: (context, state) {
        if (state.buttonStatus == ButtonStatus.fail) {
          errorController.add(ErrorAnimationType.shake);
          Future.delayed(Duration(milliseconds: 500), () {
            codeController.clear();
            _bloc!.add(VerifyCodeChanged(codeController.text));
          });
        }
      },
      child: Scaffold(
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
                        if (widget.title != null)
                          Text(widget.title!,
                              style: widget.titleStyle ??
                                  TextConfigs.kText80Bold_2),
                        SizedBox(height: 28.h),
                        if (widget.subtitle1 != null)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.subtitle1!,
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
                            symbol: !widget.disableCenterLine
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 2.h,
                                      width: 25.w,
                                      color: widget.pinTheme?.inactiveColor ??
                                          ColorConfigs.kColor3,
                                      margin: EdgeInsets.only(left: 30.w),
                                    ),
                                  )
                                : null,
                            onChanged: widget.onChanged,
                            onCompleted: (val) async {
                              if (!widget.autoVerify) return;
                              _bloc!.add(VerifyCodeSubmitted(widget.onVerify));
                            },
                            pinTheme: widget.pinTheme ??
                                PinTheme(
                                  fieldHeight: 120.h,
                                  fieldWidth: 100.w,
                                  borderWidth: 1,
                                  activeColor: widget.primaryColor ??
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
                            if (widget.subtitle2Left != null)
                              Text(
                                widget.subtitle2Left!,
                                style: widget.subtitle2LeftStyle ??
                                    TextConfigs.kText40Normal_2,
                              ),
                            if (widget.subtitle2Right != null)
                              InkWell(
                                onTap: widget.onSubtitle2RightTap,
                                child: Text(
                                  widget.subtitle2Right!,
                                  style: widget.subtitle2RightStyle ??
                                      TextConfigs.kText40Normal_4
                                          .copyWith(color: widget.primaryColor),
                                ),
                              )
                          ],
                        )),
                        SizedBox(height: 240.h),
                        BlocSelector<VerifyCodeBloc, VerifyCodeState,
                            ButtonStatus>(
                          selector: (state) => state.buttonStatus,
                          builder: (context, buttonStatus) {
                            return Container(
                              alignment: Alignment.center,
                              child: ProgressButtonAnimation(
                                height: 120.h,
                                maxWidth: _size.width,
                                state: buttonStatus,
                                onPressed: () {
                                  if (widget.autoVerify ||
                                      codeController.text.length <
                                          codeController.text.length) return;

                                  _bloc!.add(VerifyCodeSubmitted(
                                    widget.onVerify,
                                  ));
                                },
                                stateWidgets: {
                                  ButtonStatus.idle: Text(
                                      widget.buttonSuccessText ??
                                          "VERIFY ${widget.phoneNumber == null ? "EMAIL" : "PHONE"}",
                                      style: widget.buttonTextStyle ??
                                          TextConfigs.kTextConfig),
                                  ButtonStatus.fail: Text(
                                      widget.buttonErrorText ?? "Có lỗi xảy ra",
                                      style: widget.buttonTextStyle ??
                                          TextConfigs.kTextConfig),
                                  ButtonStatus.success: Text(
                                      widget.buttonSuccessText ??
                                          "VERIFY ${widget.phoneNumber == null ? "EMAIL" : "PHONE"}",
                                      style: widget.buttonTextStyle ??
                                          TextConfigs.kTextConfig),
                                },
                                stateColors: {
                                  ButtonStatus.idle: widget.primaryColor ??
                                      ColorConfigs.kColor4,
                                  ButtonStatus.loading: widget.primaryColor ??
                                      ColorConfigs.kColor4,
                                  ButtonStatus.fail: widget.buttonErrorColor ??
                                      ColorConfigs.kColor5,
                                  ButtonStatus.success:
                                      widget.buttonSuccessColor ??
                                          ColorConfigs.kColor4,
                                },
                              ),
                            );
                          },
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
                          child: BlocSelector<VerifyCodeBloc, VerifyCodeState,
                              String>(
                            selector: (state) => state.code,
                            builder: (context, code) {
                              return Keyboard(
                                onKeyboardTap: (val) {
                                  if (codeController.text.length >=
                                      widget.length) return;
                                  codeController.text += val;
                                  _bloc!.add(
                                      VerifyCodeChanged(codeController.text));
                                },
                                textStyle: widget.keyboardTextStyle ??
                                    TextConfigs.kText72Bold_2,
                                numHeight: 133.h,
                                numWidth: _size.width / 3 - 40.w,
                                rightButtonFn: () {
                                  if (codeController.text.length > 0) {
                                    codeController.text = codeController.text
                                        .substring(
                                            0, codeController.text.length - 1);
                                    _bloc!.add(
                                      VerifyCodeChanged(codeController.text),
                                    );
                                  }
                                },
                                rightIcon: Icon(
                                  Icons.backspace_outlined,
                                  color: ColorConfigs.kColor2,
                                ),
                                style: KeyboardStyle.STYLE1,
                              );
                            },
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
