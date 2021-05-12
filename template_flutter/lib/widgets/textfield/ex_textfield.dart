import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/textfield/customTextInput.dart';

class ExTextField extends StatefulWidget {
  const ExTextField({Key? key}) : super(key: key);

  @override
  _ExTextFieldState createState() => _ExTextFieldState();
}

class _ExTextFieldState extends State<ExTextField> {
  TextEditingController _password = TextEditingController();

  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 50),
                padding: EdgeInsets.only(left: 10, right: 10),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(15)
                // ),
                child: TextFormField(
                  controller: _password,
                  obscureText: !showPass,
                  inputFormatters: [CustomTextInputFormatter(3, ".")],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "hintText",
                    labelText: "labelText",
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5)),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                      size: 20,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      child: Container(
                        child: Icon(
                          showPass ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
