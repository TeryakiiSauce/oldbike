import 'package:flutter/cupertino.dart';
import 'package:oldbike/screens/home/home.dart';
import 'package:oldbike/screens/profile/profile.dart';
import 'package:oldbike/screens/tracking/location_usage_agreement.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

enum TabScreen {
  home,
  track,
  profile,
  statistics,
  locationUsageAgreement,
}

class Screen {
  static TabScreen currentTabScreen = TabScreen.home;
  final BuildContext context;
  final Color activeTabIconColor = kcAccentT3;
  final Color inactiveTabIconColor = kcPrimaryT8;

  final List<Widget> _tabScreens = const [
    HomeScreen(),
    LocationUsageAgreementScreen(),
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
}
