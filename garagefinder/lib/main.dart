import 'package:flutter/material.dart';
import 'package:garagefinder/screens/login_screen2.dart';
import 'package:garagefinder/screens/map_test_screen.dart';
// import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Dummy Login',
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      // ),
      home: LoginPage(),
    );
  }
}
