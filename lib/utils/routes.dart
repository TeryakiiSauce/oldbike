import 'package:flutter/widgets.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/login-signup/signup.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/tab_view_controller.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  TabViewController.screen: (context) => const TabViewController(),
  LoginScreen.screen: (context) => const LoginScreen(),
  SignUpScreen.screen: (context) => const SignUpScreen(),
  HomeScreen.screen.name: (context) => const HomeScreen(),
  ProfileScreen.screen.name: (context) => const ProfileScreen(),
  StatisticsScreen.screen.name: (context) => StatisticsScreen(
        statsInfo: RideStatistics(
          averageSpeed: 0.0,
          currentSpeed: 0.0,
          distanceTravelled: 0.0,
          downhillDistance: 0.0,
          elevationGained: 0.0,
          altitude: 0.0,
          previousAltitude: 0.0,
          minAltitude: 0.0,
          maxAltitude: 0.0,
          timeElapsed: const Duration(),
          topSpeed: 0.0,
          uphillDistance: 0.0,
        ),
      ),
};
