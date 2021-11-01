import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:template_flutter/common/color_config.dart';
import 'package:template_flutter/common/text_config.dart';
import 'package:template_flutter/view_models/crypto_login_flow/login_bloc/login_bloc.dart';

typedef LoginCallback = Future<void> Function(String email, String password,
    void Function() onSuccess, void Function() onFailed);

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    this.rememberMeChanged,
    this.onForgotPasswordClicked,
    required this.onLoginClicked,
    this.primaryColor,
    this.backgroundColor,
    this.subtitle,
    this.logo,
    this.subtitleStyle,
    this.textFieldStyle,
    this.buttonIdleText,
    this.buttonErrorText,
    this.buttonSuccessText,
    this.buttonErrorColor,
    this.buttonSuccessColor,
    this.buttonTextStyle,
    this.buttonBorderRadius,
    this.forgotPasswordText,
    this.rememberMeText,
    this.textFieldDecoration,
  })  : assert((rememberMeChanged == null && rememberMeText == null) ||
            (rememberMeChanged != null && rememberMeText != null)),
        assert((forgotPasswordText == null &&
                onForgotPasswordClicked == null) ||
            (forgotPasswordText != null && onForgotPasswordClicked != null)),
        assert(subtitle == null && subtitleStyle == null),
        super(key: key);

  final ValueChanged<bool>? rememberMeChanged;
  final GestureTapCallback? onForgotPasswordClicked;
  final LoginCallback onLoginClicked;
  final Color? primaryColor;
  final Color? backgroundColor;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? logo;
  final TextStyle? textFieldStyle;
  final String? buttonIdleText;
  final String? buttonErrorText;
  final String? buttonSuccessText;
  final Color? buttonErrorColor;
  final Color? buttonSuccessColor;
  final TextStyle? buttonTextStyle;
  final double? buttonBorderRadius;
  final String? forgotPasswordText;
  final String? rememberMeText;
  final InputDecoration? textFieldDecoration;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  LoginBloc? _bloc;

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = BlocProvider.of<LoginBloc>(context, listen: false);
    }
    _email.text = _bloc!.state.email;
    _password.text = _bloc!.state.password;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? ColorConfigs.kColor1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 100.h),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 98.h,
                  ),
                  if (widget.logo != null) widget.logo!,
                  SizedBox(
                    height: 32.h,
                  ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      style:
                          widget.subtitleStyle ?? TextConfigs.kText40Normal_2,
                    ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 200.h,
                  ),
                ],
              ),
              TextFormField(
                controller: _email,
                style: widget.textFieldStyle ?? TextConfigs.kText40Normal_2,
                onChanged: (val) => _bloc!.add(LoginEmailChanged(val)),
                cursorColor: widget.primaryColor ?? ColorConfigs.kColor4,
                keyboardType: TextInputType.emailAddress,
                decoration: widget.textFieldDecoration ??
                    InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 40.h, horizontal: 24.w),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  widget.primaryColor ?? ColorConfigs.kColor4)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorConfigs.kColor7)),
                      hintStyle: widget.textFieldStyle
                              ?.copyWith(color: ColorConfigs.kColor7) ??
                          TextConfigs.kText40Normal_7,
                      hintText: "Email",
                    ),
              ),
              BlocSelector<LoginBloc, LoginState, String>(
                selector: (state) => state.emailValidator,
                builder: (context, emailValidator) {
                  return SizedBox(
                    height: 50.h,
                    child: emailValidator != ""
                        ? Container(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              emailValidator,
                              style: TextConfigs.kText40Normal_5,
                            ),
                          )
                        : SizedBox.shrink(),
                  );
                },
              ),
              TextFormField(
                onChanged: (val) => _bloc!.add(LoginPasswordChanged(val)),
                controller: _password,
                style: widget.textFieldStyle ?? TextConfigs.kText40Normal_2,
                cursorColor: widget.primaryColor ?? ColorConfigs.kColor4,
                obscureText: true,
                decoration: widget.textFieldDecoration ??
                    InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 40.h, horizontal: 24.w),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorConfigs.kColor7)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  widget.primaryColor ?? ColorConfigs.kColor4)),
                      hintStyle: widget.textFieldStyle
                              ?.copyWith(color: ColorConfigs.kColor7) ??
                          TextConfigs.kText40Normal_8,
                      hintText: "Password",
                    ),
              ),
              BlocSelector<LoginBloc, LoginState, String>(
                selector: (state) => state.passwordValidator,
                builder: (context, passwordValidator) {
                  return passwordValidator != ""
                      ? Container(
                          height: 50.h,
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            passwordValidator,
                            style: TextConfigs.kText40Normal_5,
                          ))
                      : SizedBox.shrink();
                },
              ),
              SizedBox(
                height: 70.h,
              ),
              if (widget.rememberMeText != null)
                InkWell(
                  onTap: () {
                    _bloc!.add(LoginRememberMeChanged(
                        !_bloc!.state.rememberMe, widget.rememberMeChanged!));
                  },
                  child: Container(
                    height: 84.h,
                    child: Row(
                      children: [
                        BlocSelector<LoginBloc, LoginState, bool>(
                          selector: (state) => state.rememberMe,
                          builder: (context, rememberMe) {
                            return Container(
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                color: rememberMe
                                    ? widget.primaryColor ??
                                        ColorConfigs.kColor4
                                    : Colors.transparent,
                                border: Border.all(
                                    color: widget.primaryColor ??
                                        ColorConfigs.kColor4),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Flexible(
                          child: Container(
                              height: 84.h,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.rememberMeText ?? "Remember me",
                                style: TextConfigs.kText40Normal_2,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 100.h,
              ),
              Container(
                alignment: Alignment.center,
                child: BlocSelector<LoginBloc, LoginState, ButtonStatus>(
                  selector: (state) => state.buttonStatus,
                  builder: (context, buttonStatus) {
                    return ProgressButtonAnimation(
                      height: 120.h,
                      maxWidth: _size.width,
                      state: buttonStatus,
                      radius: widget.buttonBorderRadius ?? 100,
                      onPressed: () => _bloc!.add(
                        LoginClicked(widget.onLoginClicked),
                      ),
                      stateWidgets: {
                        ButtonStatus.idle: Text(
                          widget.buttonIdleText ?? "LOG IN",
                          style:
                              widget.buttonTextStyle ?? TextConfigs.kTextConfig,
                        ),
                        ButtonStatus.fail: Text(
                          widget.buttonErrorText ?? "Có lỗi xảy ra",
                          style:
                              widget.buttonTextStyle ?? TextConfigs.kTextConfig,
                        ),
                        ButtonStatus.success: Text(
                          widget.buttonSuccessText ?? "LOG IN",
                          style:
                              widget.buttonTextStyle ?? TextConfigs.kTextConfig,
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
                    );
                  },
                ),
              ),
              SizedBox(
                height: 75.h,
              ),
              if (widget.forgotPasswordText != null)
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      _bloc!.add(LoginForgotPasswordClicked(
                          widget.onForgotPasswordClicked!));
                    },
                    child: Text(
                      widget.forgotPasswordText!,
                      style: TextConfigs.kText40Normal_4
                          .copyWith(color: widget.primaryColor),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
