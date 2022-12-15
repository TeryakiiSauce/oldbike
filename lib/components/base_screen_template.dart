import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/models/user.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BaseScreenTemplate extends StatefulWidget {
  final String title;
  final Widget body;
  final bool signOutButton;

  const BaseScreenTemplate({
    super.key,
    required this.title,
    required this.body,
    this.signOutButton = true,
  });

  @override
  State<BaseScreenTemplate> createState() => _BaseScreenTemplateState();
}

class _BaseScreenTemplateState extends State<BaseScreenTemplate> {
  MyUser user = MyUser(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    debugPrint('user email: ${user.getUserInfo()?.email}');
    debugPrint('user email: ${user.getUserInfo()?.uid}');

    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: CupertinoNavigationBar(
        backgroundColor: kcAppBar,
        middle: Text(
          widget.title,
          style: ktsNormal,
        ),
        trailing: widget.signOutButton
            ? CupertinoButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Navigator.pop(TabViewController.tabControllerContext);
                  user.signOut();
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: LoginScreen.screen),
                    screen: const LoginScreen(displaySignInPage: true),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: const Icon(
                  CupertinoIcons.power,
                  size: 15.0,
                  color: kcAccent,
                ),
              )
            : const Text(''),
      ),
      body: widget.body,
    );
  }
}
