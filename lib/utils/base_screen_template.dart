import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';

class BaseScreenTemplate extends StatelessWidget {
  final String title;
  final Widget body;

  const BaseScreenTemplate({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: CupertinoNavigationBar(
        backgroundColor: kcAppBar,
        middle: Text(
          title,
          style: ktsAppBar,
        ),
        trailing: IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              // TODO: fix this logout button
              Navigator.pushReplacementNamed(context, LoginScreen.screen);
            },
            icon: const Icon(
              CupertinoIcons.power,
              size: 20.0,
            )),
      ),
      body: body,
    );
  }
}
