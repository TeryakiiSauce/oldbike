///
/// This file includes the theme data as well as the screen routes information.
/// === === === === ===

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/tab_view_controller.dart';
import 'package:oldbike/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        useMaterial3: true,
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
        TabViewController.screen: (context) => const TabViewController(),
        LoginScreen.screen: (context) => const LoginScreen(),
        HomeScreen.screen.name: (context) => const HomeScreen(),
        ProfileScreen.screen.name: (context) => const ProfileScreen(),
        StatisticsScreen.screen.name: (context) => const StatisticsScreen(),
      },
      initialRoute: LoginScreen.screen,
    );
  }
}
