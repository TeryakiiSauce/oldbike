import 'package:flutter/material.dart';

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
        Text(title),
        child,
      ],
    );
  }
}
