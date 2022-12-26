///
/// This file simply creates the business's app logo.
/// Logo on top and the text 'Old Bike' at the bottom.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 75.0,
          child: Image.asset('images/Old Bike App Logo - Transparent 2x.png'),
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Center(
          child: Text(
            'OLD BIKE',
            style: ktsSmallLabelWithSpacing,
          ),
        ),
      ],
    );
  }
}
