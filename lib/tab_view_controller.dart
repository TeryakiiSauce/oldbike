///
/// This file controls the content of each tab and displays the appropriate screens.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/platform_based_widgets.dart';
import 'package:oldbike/models/screen.dart';

class TabViewController extends StatefulWidget {
  static const String screen = 'tabview';

  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  late Screen screen;

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

    debugPrint('switched to screen: ${tempScreen.name.toUpperCase()} screen.');

    setState(() {
      Screen.currentTabScreen = tempScreen;
    });
  }

  List<BottomNavigationBarItem> getNavBarItems() => screen.buildBottomNavBar(
        {
          TabScreen.home: [
            const Icon(Icons.home_rounded),
            'Home',
          ],
          TabScreen.track: [
            const Icon(Icons.play_arrow_rounded),
            'Track',
          ],
          TabScreen.profile: [
            const Icon(Icons.person),
            'Profile',
          ],
        },
      );

  @override
  void initState() {
    super.initState();
    Screen.currentTabScreen = TabScreen.home;
  }

  @override
  Widget build(BuildContext context) {
    screen = Screen(context: context);

    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: AppBar(
        title: screen.getScreenTitle(screen: Screen.currentTabScreen),
        backgroundColor: kcAppBar,
        actions: screen.getActions(screen: Screen.currentTabScreen),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kcPrimaryS4,
        iconSize: 30.0,
        selectedItemColor: kcAccent,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: Screen.currentTabScreen.index,
        enableFeedback: true,
        onTap: (tabSelectedIndex) {
          switchTabView(tabSelectedIndex);
        },
        items: getNavBarItems(),
      ),
      body: screen.getScreenWidget(screen: Screen.currentTabScreen),
    );
  }
}
