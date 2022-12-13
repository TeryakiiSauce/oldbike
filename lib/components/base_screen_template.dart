import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/models/user.dart';
import 'package:oldbike/tab_view_controller.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';

class BaseScreenTemplate extends StatefulWidget {
  final String title;
  final Widget body;

  const BaseScreenTemplate({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<BaseScreenTemplate> createState() => _BaseScreenTemplateState();
}

class _BaseScreenTemplateState extends State<BaseScreenTemplate> {
  MyUser user = MyUser(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    debugPrint('user email: ${user.getUserInfo()?.email}');
    debugPrint('is anon?: ${user.getUserInfo()?.isAnonymous}');

    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: CupertinoNavigationBar(
        backgroundColor: kcAppBar,
        middle: Text(
          widget.title,
          style: ktsNormal,
        ),
        trailing: CupertinoButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(TabViewController.tabControllerContext);
            // user.getUserInfo()?.isAnonymous != true ? user.signOut() : null;
            user.signOut();
          },
          child: const Icon(
            CupertinoIcons.power,
            size: 15.0,
            color: kcAccent,
          ),
        ),
      ),
      body: widget.body,
    );
  }
}
