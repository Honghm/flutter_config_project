import 'package:flutter/material.dart';

import 'multi_checkbox.dart';

class MultiCheckboxScreen extends StatelessWidget {
  static final id = "MultiCheckboxScreen";

  final List<String> items = [
    for (int i = 0; i <= 20; i++)
      "Item $i Item $i Item $i Item $i Item $i Item $i "
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi checkbox demo'),
      ),
      body: Center(
        child: MultiCheckbox(
          items: items,
          checkedFillColor: Colors.red,
          haveCheckIcon: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          checkIconColor: Colors.white,
          titleMaxLines: 1,
          unCheckedBorderColor: Colors.yellow,
          onCheckChanged: (result) {
            print(result.length);
          },
          crossAxisCount: 4,
        ),
      ),
    );
  }
}
