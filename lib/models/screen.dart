import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

enum TabScreen {
  home,
  track,
  profile,
  statistics,
}

class Screen {
  static TabScreen currentTabScreen = TabScreen.home;
  final BuildContext context;
  final Color activeTabIconColor = kcAccentT3,
      inactiveTabIconColor = CupertinoColors.inactiveGray;

  final List<Widget> _tabScreens = const [
    HomeScreen(),
    RideTrackingScreen(),
    ProfileScreen(),
  ];
  List<Widget> get tabScreens => _tabScreens;

  final List<PersistentBottomNavBarItem> _tabIcons = [];
  List<PersistentBottomNavBarItem> get tabIcons => _tabIcons;

  Screen({required this.context}) {
    _tabIcons.addAll(
      [
        // Home / Feed
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ('Feed'),
          activeColorPrimary: activeTabIconColor,
          inactiveColorPrimary: inactiveTabIconColor,
        ),

        // Track
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.play),
          title: ('Track'),
          activeColorPrimary: activeTabIconColor,
          inactiveColorPrimary: inactiveTabIconColor,
        ),

        // Profile
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person_alt_circle),
          title: ('Profile'),
          activeColorPrimary: activeTabIconColor,
          inactiveColorPrimary: inactiveTabIconColor,
        ),
      ],
    );
  }

  // final Map<TabScreen, Map<String, dynamic>> _screenDetailsList = {
  //   TabScreen.home: {
  //     'screenWidget': const HomeScreen(),
  //     'title': 'Home',
  //     'actions': [],
  //   },
  //   TabScreen.track: {
  //     'screenWidget': const RideTrackingScreen(),
  //     'title': 'Track',
  //     'actions': [],
  //   },
  //   TabScreen.profile: {
  //     'screenWidget': const ProfileScreen(),
  //     'title': 'Profile',
  //     'actions': [],
  //   },
  //   TabScreen.statistics: {
  //     'screenWidget': const StatisticsScreen(),
  //     'title': 'Statistics',
  //     'actions': [],
  //   },
  // };

  // Future<void> fireHapticFeedback() async =>
  //     await HapticFeedback.selectionClick();

  // List<BottomNavigationBarItem> buildBottomNavBar(
  //     Map<TabScreen, List<dynamic>> tabScreens) {
  //   List<BottomNavigationBarItem> list = [];
  //   for (List<dynamic> currentScreenDetails in tabScreens.values) {
  //     list.add(
  //       BottomNavigationBarItem(
  //         icon: currentScreenDetails[0],
  //         label: currentScreenDetails[1],
  //         tooltip: '',
  //       ),
  //     );
  //   }
  //   return list;
  // }
//
  // Text getScreenTitle({required TabScreen screen}) => Text(
  //       _screenDetailsList[screen]!['title'],
  //     );
//
  // Widget getScreenWidget({required TabScreen screen}) =>
  //     _screenDetailsList[screen]!['screenWidget'];
//
  // List<Widget> getActions({required TabScreen screen}) {
  //   switch (screen) {
  //     case TabScreen.profile:
  //       _screenDetailsList[screen]!['actions'] = [
  //         IconButton(
  //           onPressed: () {
  //             fireHapticFeedback();

  //             Navigator.pushReplacementNamed(
  //               context,
  //               LoginScreen.screen,
  //             );
  //           },
  //           icon: const Icon(Icons.exit_to_app_rounded),
  //         ),
  //       ];
  //       break;
  //     default:
  //       _screenDetailsList[screen]!['actions'] = [Container()];
  //   }

  //   return _screenDetailsList[screen]!['actions'];
  // }
}
