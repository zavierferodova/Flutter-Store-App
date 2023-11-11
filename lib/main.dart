import 'package:flutter/cupertino.dart';
import 'package:store_app/views/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Store App',
      theme: CupertinoThemeData(
          scaffoldBackgroundColor: Color(0xfffbfbfb)
      ),
      home: Home(),
    );
  }
}
