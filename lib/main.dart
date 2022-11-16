import 'package:flutter/material.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/utils/colors.dart';

void main() {
  runApp(const OldBikeApp());
}

class OldBikeApp extends StatelessWidget {
  const OldBikeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Old Bike',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kcPrimary,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kcAccent,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          iconColor: kcAccent,
        ),
      ),
      routes: {
        LoginScreen.screen: (context) => const LoginScreen(),
        HomeScreen.screen: (context) => const HomeScreen(),
      },
      initialRoute: LoginScreen.screen,
    );
  }
}
