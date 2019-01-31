import 'package:flutter/material.dart';

import 'package:sqlite/widgets/home_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SqlLite...',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeController(title: 'Flutter SqlLite...'),
    );
  }
}