import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/bottom_bar_navigation/bottom_bar.dart';
import 'package:template_flutter/widgets/button/dropdown_button/dropdown_button.dart';
import 'package:template_flutter/widgets/calendar/calendar.dart';
import 'package:template_flutter/widgets/listview/grouplist.dart';
import 'package:template_flutter/widgets/pin_code/ex_pin_code.dart';
import 'package:template_flutter/widgets/textfield/ex_textfield.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Calendar(),
    );
  }
}
