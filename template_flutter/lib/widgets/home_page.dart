
import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/button/example.dart';
import 'package:template_flutter/widgets/button/progress_state_button/ex_progress_button.dart';
import 'package:template_flutter/widgets/button/progress_button_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: ExProgressButtonAnimation(),
      ),
    );
  }
}
