import 'package:flutter/material.dart';
import 'package:oldbike/screens/login-signup/login.dart';

void main() {
  runApp(const OldBikeApp());
}

class OldBikeApp extends StatelessWidget {
  const OldBikeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Old Bike',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF48435C),
      ),
      home: const LoginScreen(),
    );
  }
}
