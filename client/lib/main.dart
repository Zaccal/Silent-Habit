import 'package:flutter/material.dart';
import 'package:silent_habit/pages/home.dart';
import 'package:silent_habit/pages/sign-up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFEDECE3),
        body: const SignUpPage(),
      ),
    );
  }
}
