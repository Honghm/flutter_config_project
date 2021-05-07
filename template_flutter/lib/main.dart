import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
