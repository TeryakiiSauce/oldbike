import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';

class LabelledWidget extends StatelessWidget {
  final String title;
  final Widget child;

  /// This value gives padding to:
  /// - _top_
  /// - _left_
  /// - _right_
  final double titlePadding;

  /// This value gives _Horizontal_ padding ONLY.
  final double childPadding;

  const LabelledWidget({
    super.key,
    required this.title,
    required this.child,
    this.titlePadding = 0,
    this.childPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: titlePadding, left: titlePadding, right: titlePadding),
          child: Text(
            title,
            style: ktsHeading,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: childPadding),
          child: child,
        ),
      ],
    );
  }
}
