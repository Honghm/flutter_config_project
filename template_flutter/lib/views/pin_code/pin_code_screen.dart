import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatefulWidget {
  static final id = 'PinCodeScreen';
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController controller = TextEditingController();
  final maxLength = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Enter Passcode',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: 200,
                child: PinCodeTextField(
                  focusNode: CannotFocusNode(),
                  controller: controller,
                  appContext: context,
                  blinkWhenObscuring: false,
                  obscureText: true,
                  obscuringCharacter: ' ',
                  showCursor: false,
                  length: maxLength,
                  onChanged: (value) {},
                  animationType: AnimationType.none,
                  enablePinAutofill: false,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                    inactiveColor: Colors.pink,
                    inactiveFillColor: Colors.transparent,
                    activeFillColor: Colors.pink,
                    shape: PinCodeFieldShape.circle,
                    activeColor: Colors.pink,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: _buildNumPad(),
                  childAspectRatio: 2,
                  crossAxisSpacing: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildNumPad() {
    List<Widget> result = [];
    for (int i = 1, k = 1; i <= 12; i++) {
      if (i == 10) {
        result.add(SizedBox());
        continue;
      } else if (i == 12) {
        result.add(
          InkWell(
            onTap: () {
              final String text = controller.text;
              if (text.isNotEmpty)
                controller.text = text.substring(0, text.length - 1);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
        );
        continue;
      }
      final currentVal = k;
      result.add(
        Material(
          child: InkWell(
            onTap: () {
              if (controller.text.length == maxLength) return;
              controller.text += currentVal.toString();
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                currentVal.toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                  border: currentVal == 0
                      ? null
                      : Border(bottom: BorderSide(color: Colors.grey))),
            ),
          ),
        ),
      );
      k++;
      if (k == 10) k = 0;
    }
    return result;
  }
}

class CannotFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
