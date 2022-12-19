import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';

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

  void goToLoginScreen(NavigatorState navigatorState) {
    navigatorState.context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    // print('user email: ${user.getUserInfo()?.email}');
    // print('user ID: ${user.getUserInfo()?.uid}');

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
                onPressed: () async {
                  NavigatorState navigatorState = Navigator.of(context);
                  HapticFeedback.lightImpact();
                  await user.signOut();
                  goToLoginScreen(navigatorState);
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
