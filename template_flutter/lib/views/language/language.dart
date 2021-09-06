import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/common/utils/tools.dart';
import 'package:template_flutter/generated/i10n.dart';
import 'package:template_flutter/view_models/app_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            MessageWithParameters(),
          ],
        ),
      ),
    );
  }
}

class MessageWithParameters extends StatefulWidget {
  const MessageWithParameters({
    Key? key,
  }) : super(key: key);

  @override
  _MessageWithParametersState createState() => _MessageWithParametersState();
}

class _MessageWithParametersState extends State<MessageWithParameters> {
  String username = '';
  double number = 0;
  double sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    final chicken = AppLocalizations.of(context)?.chicken ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.enterYourNameHere,
            ),
            onChanged: (val) => setState(() {
              username = val;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.enterAnyNumberHere,
              ),
              onChanged: (val) => setState(() {
                number = double.tryParse(val) ?? 0;
              }),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.yourNameIs(username),
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.userNumberIs(username, number),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.todayTomorrow(
              DateTime.now(),
              DateTime.now().add(Duration(days: 1)),
            ),
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          Slider(
            value: sliderValue,
            onChanged: (val) => setState(
              () {
                sliderValue = val;
              },
            ),
            min: 0,
            max: 10,
            divisions: 10,
            label: AppLocalizations.of(context)
                    ?.nThings(sliderValue.toInt(), chicken) ??
                "",
          ),
        ],
      ),
    );
  }
}
