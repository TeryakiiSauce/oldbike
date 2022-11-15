import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/utils/colors.dart';

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final String label, result, unit;
  final double size;

  /// Creates an `Icon()` with a circular background.
  ///
  /// Note: If the `label` is empty, then the result & unit strings will *NOT* be displayed.
  const CircularIcon({
    Key? key,
    required this.icon,
    this.label = '',
    this.result = '0.0',
    this.unit = '',
    this.size = 6,
  }) : super(key: key);

  /// Checks if the label for an icon is empty or not.
  ///
  /// - if the label **is** empty, then nothing other than the icon will be displayed.
  ///
  /// - If the label is **not** empty, then the other labels will be shown. These text labels are: result & unit.
  Column _getLabel() {
    if (label != '') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
          ),
          Text(
            result,
            style: ktsCardTitle,
          ),
          Text(
            unit.toUpperCase(),
          ),
        ],
      );
    } else {
      return Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size * 10,
            minWidth: size * 10,
          ),
          child: FittedBox(
            child: CircleAvatar(
              backgroundColor: kcPrimaryS3,
              foregroundColor: kcWhite400,
              child: Icon(
                icon,
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: (size * 10) + 10, // Added extra spacing, just in case.
            maxWidth: (size * 10) + 30, // Added extra spacing, just in case.
            minHeight: 120.0,
            maxHeight: 140.0,
          ),
          child: _getLabel(),
        ),
      ],
    );
  }
}
