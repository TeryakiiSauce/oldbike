///
/// This file controls the content of each tab and displays the appropriate screens.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/utils/colors.dart';

class TabViewController extends StatefulWidget {
  static const String screen = 'tabview';

  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  int tabviewScreenIndex = 0;
  late BuildContext currentContext;
  final List<Map<String, dynamic>> screensMapsList = [];
  final Map<String, List<Widget>> actions = {};

  Future<void> switchTabView(int screenIndex) async {
    await HapticFeedback.selectionClick();

    setState(() {
      tabviewScreenIndex = screenIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    currentContext = context;

    actions.addAll(
      {
        'home': [
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
          'screenWidget': const ProfileScreen(),
          'title': 'Profile',
          'actions': actions['profile'],
        },
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Text appBarTitle = Text(screensMapsList[tabviewScreenIndex]['title']);
    final List<Widget> actionsList =
        screensMapsList[tabviewScreenIndex]['actions'];
    final Widget screenBody =
        screensMapsList[tabviewScreenIndex]['screenWidget'];

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
        currentIndex: tabviewScreenIndex,
        enableFeedback: true,
        onTap: (value) {
          switchTabView(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: screenBody,
    );
  }
}
