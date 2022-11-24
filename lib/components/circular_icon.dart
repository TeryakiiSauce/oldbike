import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/utils/colors.dart';

// This file includes two classes that are related to each other
// 1. CircularIcon
// 2. CircularIconLabel

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final double borderThickness;
  final Color backgroundColor, foregroundColor;
  final double size;
  final bool invertedColors;
  final Widget child;

  /// Only creates an `Icon()` with a circle background. The colors can be customized.
  ///
  /// To add a label to the icon, make sure to pass a `CircularIconLabel()` widget to the child property.
  const CircularIcon({
    super.key,
    required this.icon,
    required this.child,
    this.size = 6,
    this.borderThickness = 0,
    this.backgroundColor = kcPrimaryS3,
    this.foregroundColor = kcWhite400,
    this.invertedColors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This _outer_ CircleAvatar() is for the border of the circular icon.
        CircleAvatar(
          radius: borderThickness != 0 ? size + 20 + borderThickness : null,
          backgroundColor: invertedColors
              ? foregroundColor.withOpacity(0.3)
              : backgroundColor.withOpacity(0.3),
          child: CircleAvatar(
            radius: size + 20,
            backgroundColor: invertedColors ? foregroundColor : backgroundColor,
            foregroundColor: invertedColors ? backgroundColor : foregroundColor,
            child: Icon(icon),
          ),
        ),

        SizedBox(
          height: child.runtimeType == const CircularIconLabel().runtimeType
              ? 15.0
              : null,
        ),

        // The labels to be displayed.
        child,
      ],
    );
  }
}

class CircularIconLabel extends StatelessWidget {
  final String label, result, unit;
  final bool isVerticalLabel;

  /// Adds a label to the `CircularIcon()` widget.
  ///
  /// By default, the labels are shown horizontally.
  const CircularIconLabel({
    Key? key,
    this.label = '',
    this.result = '0.0',
    this.unit = '',
    this.isVerticalLabel = false,
  }) : super(key: key);

  /// Returns the labels on top of each other while the icon remains at the topmost.
  Column _getVerticalLabel() => Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            result,
            style: ktsCardTitle,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            unit.toUpperCase(),
          ),
        ],
      );

  /// Returns the labels as a horizontal line. The icon will be at the leftmost position.
  Row _getHorizontalLabel() => Row(
        children: [
          // _getIcon(),
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

  @override
  Widget build(BuildContext context) {
    return isVerticalLabel ? _getVerticalLabel() : _getHorizontalLabel();
  }
}
