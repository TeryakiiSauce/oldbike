import 'package:flutter/widgets.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/tab_view_controller.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  TabViewController.screen: (context) => const TabViewController(),
  LoginScreen.screen: (context) => const LoginScreen(),
  HomeScreen.screen.name: (context) => const HomeScreen(),
  ProfileScreen.screen.name: (context) => const ProfileScreen(),
  StatisticsScreen.screen.name: (context) => const StatisticsScreen(),
};
