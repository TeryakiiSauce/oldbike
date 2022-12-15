///
/// This file controls the content of each tab and displays the appropriate screens.
/// === === === === ===

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/models/screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class TabViewController extends StatefulWidget {
  static const String screen = 'tabview';
  static late BuildContext tabControllerContext;

  const TabViewController({super.key});

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  late Screen screen;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    screen = Screen(context: context);
    TabViewController.tabControllerContext = context;

    return PersistentTabView(
      TabViewController.tabControllerContext,
      backgroundColor: kcPrimaryS4,
      controller: controller,
      onItemSelected: (value) => HapticFeedback.selectionClick(),
      screens: screen.tabScreens,
      items: screen.tabIcons,
      navBarStyle: NavBarStyle.style12,
    );
  }
}
