///
/// This file controls the content of each tab and displays the appropriate screens.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/platform_based_widgets.dart';

enum TabScreen {
  home,
  track,
  profile,
  statistics,
}

class TabViewController extends StatefulWidget {
  static const String screen = 'tabview';

  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  late BuildContext currentContext;

  // int tabScreenIndex = TabScreens.home.index;
  TabScreen currentTabScreen = TabScreen.home;
  final List<BottomNavigationBarItem> screens = [];
  final List<Map<String, dynamic>> screensMapsList = [];
  final Map<String, List<Widget>> actions = {};

  Future<void> switchTabView(int tabIndex) async {
    await HapticFeedback.selectionClick();

    TabScreen tempScreen = TabScreen.values.elementAt(tabIndex);

    bool isCurrentlyTracking = RideTrackingScreen.isRecording;
    if (isCurrentlyTracking) {
      tempScreen = TabScreen.track;

      showDialog(
        context: context,
        builder: (context) => DynamicAlertDialog(
          approveAction: () {
            print('screen: ${TabScreen.values.elementAt(tabIndex)}');
            tempScreen = TabScreen.values.elementAt(tabIndex);
            print('temp screen: $tempScreen');
            Navigator.pop(context);
            print('ok pressed');
          },
          title: const Text('Done Tracking?'),
          content: const Text(
              'Are you sure you want to stop tracking your progress? Statistics will automatically be saved.'),
        ),
      );
    }

    print('2nd temp index: $tempScreen');

    setState(() {
      currentTabScreen = tempScreen;
    });
  }

  // Widget displayScreen({TabScreen screen = TabScreen.home}) {
  //   return screensMapsList[screen.index]['screenWidget'];
  // }

  // TabScreen getTabScreen(int index) {
  //   switch (index) {
  //     case value:

  //       break;
  //     default:
  //   }

  //   return ;
  // }

  // int getTabScreenIndex(TabScreen screen) {
  //   int index = screen.index;

  //   switch (index) {
  //     case value:

  //       break;
  //     default:
  //   }
  //   return index;
  // }

  /// To add new tabs adjust the lists/ maps below
  @override
  void initState() {
    super.initState();

    currentContext = context;

    actions.addAll(
      {
        'home': [
          Container(),
        ],
        'beginTrackingRide': [
          Container(),
        ],
        'profile': [
          IconButton(
            onPressed: () async {
              await HapticFeedback.lightImpact();

              if (!mounted) {
                return; // Reference: https://stackoverflow.com/a/73342013
              }

              Navigator.pushReplacementNamed(
                  currentContext, LoginScreen.screen);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
        'statistics': [
          Container(),
        ],
      },
    );

    screensMapsList.addAll(
      [
        {
          'screenWidget': const HomeScreen(),
          'title': 'Home',
          'actions': actions['home'],
        },
        {
          'screenWidget': const RideTrackingScreen(),
          'title': 'Track',
          'actions': actions['beginTrackingRide'],
        },
        {
          'screenWidget': const ProfileScreen(),
          'title': 'Profile',
          'actions': actions['profile'],
        },
        {
          'screenWidget': const StatisticsScreen(),
          'title': 'Statistics',
          'actions': actions['statistics'],
        },
      ],
    );

    screens.addAll(const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_arrow_rounded),
        label: 'Track',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Text appBarTitle =
        Text(screensMapsList[currentTabScreen.index]['title']);
    final List<Widget> actionsList =
        screensMapsList[currentTabScreen.index]['actions'];
    final Widget screenBody =
        screensMapsList[currentTabScreen.index]['screenWidget'];

    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: kcAppBar,
        actions: actionsList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kcPrimaryS4,
        iconSize: 30.0,
        selectedItemColor: kcAccent,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        currentIndex: currentTabScreen.index,
        enableFeedback: true,
        onTap: (tabSelectedIndex) {
          switchTabView(tabSelectedIndex);
        },
        items: screens,
      ),
      body: screenBody,
    );
  }
}
