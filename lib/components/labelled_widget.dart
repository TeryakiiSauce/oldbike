import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';

class LabelledWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const LabelledWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: ktsHeading,
        ),
        const SizedBox(
          height: 10.0,
        ),
        child,
      ],
    );
  }
}
