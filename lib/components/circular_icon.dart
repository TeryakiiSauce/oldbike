import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/utils/colors.dart';

class CircularIcon extends StatelessWidget {
  /// If the label is empty, then the result & unit strings will *NOT* be displayed.
  final String label, result, unit;

  /// Whether to display a circular border around the icon or not
  final bool hasBorder;

  final IconData icon;
  final double size;

  /// Creates an `Icon` with a circular background.
  ///
  /// Note: If the `label` is empty, then the result & unit strings will *NOT* be displayed.
  const CircularIcon({
    Key? key,
    required this.icon,
    this.label = '',
    this.result = '0.0',
    this.unit = '',
    this.size = 6,
    this.hasBorder = false,
  }) : super(key: key);

  /// Checks if the label for an icon is empty or not.
  ///
  /// - if the label **is** empty, then nothing other than the icon will be displayed.
  ///
  /// - If the label is **not** empty, then the other labels will be shown. These text labels are: result & unit.
  Widget _getLabel() {
    if (label == '') return Container();

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: (size * 10) + 10, // Added extra spacing, just in case.
        maxWidth: (size * 10) + 30, // Added extra spacing, just in case.
        minHeight: 120.0,
        maxHeight: 140.0,
      ),
      child: Column(
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
      ),
    );
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
              radius: hasBorder ? size + 18 : null,
              backgroundColor: kcPrimaryS3.withOpacity(0.3),
              child: CircleAvatar(
                backgroundColor: kcPrimaryS3,
                foregroundColor: kcWhite400,
                child: Icon(icon),
              ),
            ),
          ),
        ),

        // Either displays or hides the label part of the icon
        _getLabel(),
      ],
    );
  }
}
