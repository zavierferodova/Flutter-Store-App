import 'package:flutter/cupertino.dart';
import 'package:store_app/views/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Store App',
      theme: CupertinoThemeData(
          scaffoldBackgroundColor: Color(0xfffbfbfb)
      ),
      home: Home(),
    );
  }
}
