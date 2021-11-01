import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 122.h),
          width: _size.width,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          decoration: BoxDecoration(
              color: kycColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.h),
                topRight: Radius.circular(70.h),
              )),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 56.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100.w,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: kycColor3,
                    ),
                  ),
                ),
              ),
              headerBuild(),
              Text(
                "Forgot your password?",
                style: kText45Bold_13,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 52.h,
              ),
              TextFormField(
                controller: _email,
                style: kText40Normal_3,
                cursorColor: kycColor5,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(32.h),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kycColor5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kycColor16)),
                  hintStyle: kText40Normal_7,
                  hintText: "Email",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 52.h, bottom: 150.h),
                child: Text(
                  "Enter the email address you used to sign in to Heineken to reset your password.",
                  style: kText30Normal_17,
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
                    ButtonStatus.idle: Text("Continue", style: kTextConfig),
                    ButtonStatus.fail:
                        Text("Có lỗi xảy ra", style: kTextConfig),
                    ButtonStatus.success: Text("Continue", style: kTextConfig),
                  },
                  stateColors: {
                    ButtonStatus.idle: kycColor1,
                    ButtonStatus.loading: kycColor1,
                    ButtonStatus.fail: kycColor6,
                    ButtonStatus.success: kycColor1,
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStatus stateOnlyText = ButtonStatus.idle;

  _listenStateButton() {
    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        stateOnlyText = ButtonStatus.idle;
      });

      Navigator.pop(context);
    });
  }
}

headerBuild() {
  return Column(
    children: [
      SizedBox(
        height: 42.h,
      ),
      Container(
        height: 86.h,
        width: 263.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 86.h,
                width: 86.h,
                child: SvgPicture.asset("assets/icons/ic_app.svg")),
            Flexible(
                child: Text(
              "USDV",
              style: kText60Bold_1,
            ))
          ],
        ),
      ),
      SizedBox(
        height: 30.h,
      ),
      Container(
        child: Text(
          "Cross-Border Transactions. Simplified.",
          style: kText40Normal_3,
        ),
      ),
      SizedBox(
        height: 67.h,
      ),
    ],
  );
}
