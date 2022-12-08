import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';

enum TabScreen {
  home,
  track,
  profile,
  statistics,
}

class Screen {
  Screen({required this.context});

  static TabScreen currentTabScreen = TabScreen.home;
  final BuildContext context;
  final Map<TabScreen, Map<String, dynamic>> _screenDetailsList = {
    TabScreen.home: {
      'screenWidget': const HomeScreen(),
      'title': 'Home',
      'actions': [],
    },
    TabScreen.track: {
      'screenWidget': const RideTrackingScreen(),
      'title': 'Track',
      'actions': [],
    },
    TabScreen.profile: {
      'screenWidget': const ProfileScreen(),
      'title': 'Profile',
      'actions': [],
    },
    TabScreen.statistics: {
      'screenWidget': const StatisticsScreen(),
      'title': 'Statistics',
      'actions': [],
    },
  };

  Future<void> fireHapticFeedback() async => await HapticFeedback.lightImpact();

  List<BottomNavigationBarItem> buildBottomNavBar(
      Map<TabScreen, List<dynamic>> tabScreens) {
    List<BottomNavigationBarItem> list = [];
    for (List<dynamic> currentScreenDetails in tabScreens.values) {
      list.add(
        BottomNavigationBarItem(
          icon: currentScreenDetails[0],
          label: currentScreenDetails[1],
          tooltip: '',
        ),
      );
    }
    return list;
  }

  Text getScreenTitle({required TabScreen screen}) => Text(
        _screenDetailsList[screen]!['title'],
      );

  Widget getScreenWidget({required TabScreen screen}) =>
      _screenDetailsList[screen]!['screenWidget'];

  List<Widget> getActions({required TabScreen screen}) {
    switch (screen) {
      case TabScreen.profile:
        _screenDetailsList[screen]!['actions'] = [
          IconButton(
            onPressed: () {
              fireHapticFeedback();

              Navigator.pushReplacementNamed(
                context,
                LoginScreen.screen,
              );
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ];
        break;
      default:
        _screenDetailsList[screen]!['actions'] = [Container()];
    }

    return _screenDetailsList[screen]!['actions'];
  }

  static void displayScreen(
      {required BuildContext context, required TabScreen screen}) {
    // Navigator.pushNamed(context, screen.name);
  }
}
