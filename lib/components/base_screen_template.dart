import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/tab_view_controller.dart';
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
          style: ktsNormal,
        ),
        trailing: CupertinoButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(TabViewController.tabControllerContext);
          },
          child: const Icon(
            CupertinoIcons.power,
            size: 15.0,
            color: kcAccent,
          ),
        ),
      ),
      body: body,
    );
  }
}
