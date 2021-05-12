import 'package:flutter/material.dart';

class ExDropdownButton extends StatefulWidget {
  const ExDropdownButton({Key? key}) : super(key: key);

  @override
  _ExDropdownButtonState createState() => _ExDropdownButtonState();
}

class _ExDropdownButtonState extends State<ExDropdownButton> {
  String _value = "Value1";
List<String> list = [
  "Value1",
  "Value2",
  "Value3",
  "Value4"
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 50,
          width: 160,
          child: DropdownButton<String>(
            value: _value,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 1,
              color: Colors.black,
            ),
            onChanged: (value){
              setState(() {
                _value = value!;
              });
            },
            items: list
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
