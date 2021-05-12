import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';


class PinCode extends StatefulWidget {
  const PinCode({Key? key}) : super(key: key);

  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  bool isDone = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late StreamController<ErrorAnimationType> errorController;
  bool hasError = false;

  // FocusNode _focusNode = FocusNode();
  // final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    setState(() {
      isDone = false;
    });
    // WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    errorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: PinCodeTextField(
              length: 4,
              appContext: context,
              controller: textEditingController,
              errorAnimationController: errorController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              // focusNode: _focusNode,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              validator: (v) {
                if (v!.length == 4 && v != "1234") {
                  return "";
                } else {
                  return null;
                }
              },
              hintWidget: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle
                ),
              ),
              animationDuration: Duration(milliseconds: 300),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,

                borderWidth: 1,
                fieldHeight: 46,
                fieldWidth: 50,
                activeColor: isDone ? Colors.greenAccent : Colors.redAccent,
                inactiveFillColor: Colors.transparent,
                inactiveColor: Color(0xFFCCCCCC),
                activeFillColor: Color(0xffF8F8FA),
                selectedColor: Color(0xff0FAFDA),
                selectedFillColor: Colors.transparent,
              ),
              onChanged: (value) {
                if (value == "1234") {
                  setState(() {
                    isDone = true;
                    currentText = value;
                    // _focusNode.unfocus();
                  });
                } else {
                  setState(() {
                    isDone = false;
                    currentText = value;
                  });
                }
              },
              onCompleted: (v) {},
            ),
          ),
        ],
      ),
    );
  }
}
