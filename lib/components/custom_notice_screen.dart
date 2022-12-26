///
/// Custom widget to create a simple notice screen with a button at the bottom.
/// Useful for displaying some really important information like: Location Usage Notice.
/// === === === === ===

import 'package:flutter/cupertino.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';

class CustomNoticeScreen extends StatelessWidget {
  final String appBarTitle, title, content;
  final bool signOutButton;
  final VoidCallback onButtonPressed;

  const CustomNoticeScreen({
    super.key,
    required this.appBarTitle,
    required this.title,
    required this.content,
    required this.onButtonPressed,
    this.signOutButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: appBarTitle,
      signOutButton: signOutButton,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 100.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppLogo(),
            const SizedBox(
              height: 100.0,
            ),
            Column(
              children: [
                Text(
                  title,
                  style: ktsProfileTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  content,
                  style: ktsNormal,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            CupertinoButton(
              color: kcAccent,
              onPressed: onButtonPressed,
              child: const Text(
                'Continue',
                style: ktsNormalDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
