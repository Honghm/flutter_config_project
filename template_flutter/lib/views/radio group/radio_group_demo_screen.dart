import 'package:flutter/material.dart';
import 'package:template_flutter/views/radio%20group/radio_group.dart';

class RadioGroupDemoScreen extends StatelessWidget {
  static final id = "RadioGroupDemoScreen";

  final List<String> items = [
    for (int i = 0; i <= 20; i++)
      "Item $i Item $i Item $i Item $i Item $i Item $i "
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio group demo'),
      ),
      body: Center(
        child: RadioGroup(
          items: items,
          checkedFillColor: Colors.red,
          haveCheckIcon: true,
          shape: BoxShape.rectangle,
          icon: FlutterLogo(),
          titleMaxLines: 2,
          unCheckedBorderColor: Colors.yellow,
          onCheckChanged: (result) {
            print(result);
          },
          crossAxisCount: 3,
          margin: EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
