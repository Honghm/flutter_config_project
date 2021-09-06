import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_init.dart';
import 'common/constants/general.dart';
import 'common/constants/styles.dart';
import 'generated/i10n.dart';
import 'routes/route_observer.dart';
import 'view_models/app_model.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _app = AppModel();

  /// Build the App Theme
  ThemeData getTheme(context) {
    printLog("[AppState] build Theme");

    AppModel appModel = Provider.of<AppModel>(context);
    bool isDarkTheme = appModel.darkTheme;

    if (isDarkTheme) {
      return buildDarkTheme();
    }
    return buildLightTheme();
  }

  @override
  Widget build(BuildContext context) {
    printLog("[AppState] build");
    return ChangeNotifierProvider<AppModel>.value(
      value: _app,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          return MultiProvider(
            providers: [
              Provider<AppModel>.value(value: _app),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale(Provider.of<AppModel>(context).locale, ""),
              navigatorObservers: [MyRouteObserver()],
              localizationsDelegates: const [
                S.delegate,
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(body: AppInit()),
              routes: Routes.getAll(),
              onGenerateRoute: Routes.getRouteGenerate,
              theme: getTheme(context),
            ),
          );
        },
      ),
    );
  }
}
