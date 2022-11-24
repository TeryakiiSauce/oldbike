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
  final bool invertedColors, isVerticalLayout;
  final List<Widget> labels;

  /// Only creates an `Icon()` with a circle background. The colors can be customized.
  ///
  /// To add a label to the icon, make sure to pass a `CircularIconLabel()` widget to the child property.
  const CircularIcon({
    super.key,
    required this.icon,
    required this.labels,
    this.size = 6,
    this.borderThickness = 0,
    this.backgroundColor = kcPrimaryS3,
    this.foregroundColor = kcWhite400,
    this.invertedColors = false,
    this.isVerticalLayout = false,
  });

  /// This is place the icon on top of the child widget
  Column _getVerticalLayout() {
    List<Widget> widgets = [];

    /// I'm not exactly good at maths so I just played with the calculations until I got a result that doesn't break (overflow) the icon from the circle background.
    widgets.addAll([
      // This _outer_ CircleAvatar() is for the border of the circular icon.
      CircleAvatar(
        radius: borderThickness != 0 ? size + 20 + borderThickness : null,
        backgroundColor: invertedColors
            ? foregroundColor.withOpacity(0.3)
            : backgroundColor.withOpacity(0.3),

        // This _inner_ CircleAvatar() is for the circular icon.
        child: CircleAvatar(
          radius: size + 20,
          backgroundColor: invertedColors ? foregroundColor : backgroundColor,
          foregroundColor: invertedColors ? backgroundColor : foregroundColor,
          child: Icon(icon),
        ),
      ),

      SizedBox(
        height: labels.isNotEmpty ? 10.0 : null,
      ),
    ]);

    for (Widget label in labels) {
      widgets.add(label);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  /// TODO: [done] add documentation.
  Row _getHorizontalLayout() {
    List<Widget> widgets = [];

    /// I'm not exactly good at maths so I just played with the calculations until I got a result that doesn't break (overflow) the icon from the circle background.
    widgets.add(
      // This _outer_ CircleAvatar() is for the border of the circular icon.
      CircleAvatar(
        radius: borderThickness != 0 ? size + borderThickness : null,
        backgroundColor: invertedColors
            ? foregroundColor.withOpacity(0.3)
            : backgroundColor.withOpacity(0.3),

        // This _inner_ CircleAvatar() is for the circular icon.
        child: CircleAvatar(
          radius: size,
          backgroundColor: invertedColors ? foregroundColor : backgroundColor,
          foregroundColor: invertedColors ? backgroundColor : foregroundColor,
          child: Icon(
            icon,
            size: size / 0.65,
          ),
        ),
      ),
    );

    for (Widget label in labels) {
      widgets.add(label);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isVerticalLayout ? _getVerticalLayout() : _getHorizontalLayout();
  }
}
