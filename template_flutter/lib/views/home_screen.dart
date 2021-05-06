import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/generated/i10n.dart';
import 'package:template_flutter/view_models/app_model.dart';

import 'language.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            InkWell(
              onTap: (){

              },
              child: Container(
                height:50,

                alignment: Alignment.center,
                color: Colors.white,
                child: SwitchListTile(
                  secondary: Icon(Icons.brightness_2, color: Theme.of(context).accentColor, size: 24),
                  value: Provider.of<AppModel>(context).darkTheme,
                  activeColor: const Color(0xFF0066B4),
                  onChanged: (bool value) {
                    if (value) {
                      Provider.of<AppModel>(context, listen: false).updateTheme(true);
                    } else {
                      Provider.of<AppModel>(context, listen: false).updateTheme(false);
                    }
                  },
                  title: Text(S.of(context)!.darkTheme, style: const TextStyle(fontSize: 16)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
