import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';

class PinCodeDialog extends StatelessWidget {
  const PinCodeDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.pinTheme,
    this.negativeButtonStyle,
    this.positiveButtonStyle,
    this.onPositiveButtonTap,
    this.onNegativeButtonTap,
    required this.pinCodeTextChanged,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String description;
  final PinTheme? pinTheme;
  final ButtonStyle? negativeButtonStyle;
  final ButtonStyle? positiveButtonStyle;
  final void Function()? onPositiveButtonTap;
  final void Function()? onNegativeButtonTap;
  final void Function(String value) pinCodeTextChanged;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                )),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PinCodeTextField(
            appContext: context,
            length: 4,
            onChanged: pinCodeTextChanged,
            pinTheme: pinTheme ??
                PinTheme(
                  shape: PinCodeFieldShape.box,
                  inactiveColor: Colors.grey,
                  activeColor: Colors.grey,
                  borderWidth: 0,
                ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: OutlinedButton(
                      onPressed: onNegativeButtonTap ??
                          () => Navigator.of(context).pop(),
                      style: negativeButtonStyle,
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black54),
                      ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: OutlinedButton(
                  onPressed:
                      onPositiveButtonTap ?? () => Navigator.of(context).pop(),
                  style: positiveButtonStyle ??
                      OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
