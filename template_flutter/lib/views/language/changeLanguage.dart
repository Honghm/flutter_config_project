import 'package:flutter/material.dart';
import 'package:template_flutter/generated/i10n.dart';

import 'language.dart';
class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Language()));
              },
              child: Container(
                height:50,
                width: 200,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Text(S.of(context)!.language),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
