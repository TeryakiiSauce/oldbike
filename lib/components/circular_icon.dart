///
/// This file aims to create an Icon with a circle background (either with a border or without).
///
/// Note: This is similar to the `CircularImage()` widget.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/utils/colors.dart';

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final double borderThickness;
  final Color backgroundColor, foregroundColor;
  final double size;
  final bool invertColors, isVerticalLayout;
  final List<Widget> labels;

  /// Creates an `Icon()` with a circle background. The colors can be customized.
  ///
  /// You can also add widgets to the `labels` list & pass a _bool_ value to `isVerticalLayout` so that the widgets in the list can displayed either vertically or horizontally.
  const CircularIcon({
    super.key,
    required this.icon,
    required this.labels,
    this.size = 6,
    this.borderThickness = 0,
    this.backgroundColor = kcPrimaryS3,
    this.foregroundColor = kcPrimaryT11,
    this.invertColors = false,
    this.isVerticalLayout = false,
  });

  /// The widgets passed to the `labels` list will be placed at the bottom of the icon as a column.
  Column _getVerticalLayout() {
    List<Widget> widgets = [];

    /// Adds the icon and a spacing after it if needed.
    ///
    /// Note: I'm not exactly good at maths so I just played with the calculations until I got a result that doesn't break (overflow) the icon from the circle background.
    widgets.addAll([
      // This _outer_ CircleAvatar() is for the border of the circular icon.
      CircleAvatar(
        radius: borderThickness != 0 ? size + 20 + borderThickness : null,
        backgroundColor: invertColors
            ? foregroundColor.withOpacity(0.3)
            : backgroundColor.withOpacity(0.3),

        // This _inner_ CircleAvatar() is for the circular icon.
        child: CircleAvatar(
          radius: size + 20,
          backgroundColor: invertColors ? foregroundColor : backgroundColor,
          foregroundColor: invertColors ? backgroundColor : foregroundColor,
          child: Icon(icon),
        ),
      ),

      SizedBox(
        height: labels.isNotEmpty ? 10.0 : null,
      ),
    ]);

    /// Adds the widgets passed from the `labels` list.
    for (Widget label in labels) {
      widgets.add(label);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  /// The widgets passed to the `labels` list will be placed at the right side of the icon as a row.
  Row _getHorizontalLayout() {
    List<Widget> widgets = [];

    /// Adds the icon without any spacing.
    ///
    /// I'm not exactly good at maths so I just played with the calculations until I got a result that doesn't break (overflow) the icon from the circle background.
    widgets.add(
      // This _outer_ CircleAvatar() is for the border of the circular icon.
      CircleAvatar(
        radius: borderThickness != 0 ? size + borderThickness : null,
        backgroundColor: invertColors
            ? foregroundColor.withOpacity(0.3)
            : backgroundColor.withOpacity(0.3),

        // This _inner_ CircleAvatar() is for the circular icon.
        child: CircleAvatar(
          radius: size,
          backgroundColor: invertColors ? foregroundColor : backgroundColor,
          foregroundColor: invertColors ? backgroundColor : foregroundColor,
          child: Icon(
            icon,
            size: size / 0.65,
          ),
        ),
      ),
    );

    /// Adds the widgets passed from the `labels` list.
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
