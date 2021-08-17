import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/common/utils/tools.dart';
import 'package:template_flutter/generated/i10n.dart';
import 'package:template_flutter/view_models/app_model.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showLoading(String language) {
    final snackBar = SnackBar(
      content: Text(
        S.of(context)!.languageSuccess,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
      action: SnackBarAction(
        label: language,
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    List<Map<String, dynamic>> languages = Utils.getLanguagesList(context);
    for (var i = 0; i < languages.length; i++) {
      list.add(
        Card(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          child: ListTile(
            title: Text(languages[i]["name"]),
            onTap: () {
              Provider.of<AppModel>(context, listen: false)
                  .changeLanguage(languages[i]["code"], context);
              _showLoading(languages[i]["text"]);
            },
          ),
        ),
      );
      if (i < languages.length - 1) {
        list.add(
          const Divider(
            color: Colors.black12,
            height: 1.0,
            indent: 75,
            //endIndent: 20,
          ),
        );
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          S.of(context)!.language,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: Center(
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...list,
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
