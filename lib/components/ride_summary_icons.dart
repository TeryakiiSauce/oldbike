import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_icon.dart';
import 'package:oldbike/utils/custom_formatting.dart';

/// The class below is used to arrange the average speed, distance travelled, & elevation gained icons & labels neatly.
///
/// It does this with the help of my _two_ carefully created custom widgets `CircularIcon()` & `CircularIconLabel()` lol. It took me some time for figure it out because navigating through multiple files made me lose focus.
///
class RideSummaryIcons extends StatelessWidget {
  // To adjust design quickly
  final double borderThickness = 5.0;

  final bool isVertical, invertColors;
  final double avgSpeed, distTravelled, elevationGained;

  /// Creates a group of icons, either vertically or horizontally.
  const RideSummaryIcons({
    super.key,
    this.avgSpeed = 0.0,
    this.distTravelled = 0.0,
    this.elevationGained = 0.0,
    this.isVertical = true,
    this.invertColors = true,
  });

  /// Creates _three_ icons (with labels if specified) on top of each other.
  Widget getVerticalLayout() => CircularIconLabel(
      // icon: Icons.flash_on_rounded,
      // size: 2.0,
      // invertedColors: true,
      // label: 'my title',
      // isVerticalLabel: false,
      // result: '1235',
      // unit: 'km/ h',
      );

  /// Creates _three_ icons (with labels if specified) next to each other.
  Row _createHorizontalLayout() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CircularIcon(
              icon: Icons.flash_on_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              child: CircularIconLabel(
                isVerticalLabel: true,
                label: 'Average\nSpeed',
                result: CustomFormat.getFormattedResult(avgSpeed),
                unit: 'km/ h',
              ),
            ),
          ),
          Expanded(
            child: CircularIcon(
              icon: Icons.location_on_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              child: CircularIconLabel(
                isVerticalLabel: true,
                label: 'Distance\nTravelled',
                result: CustomFormat.getFormattedResult(distTravelled),
                unit: 'km',
              ),
            ),
          ),
          Expanded(
            child: CircularIcon(
              icon: Icons.trending_up_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              child: CircularIconLabel(
                isVerticalLabel: true,
                label: 'Elevation\nGained',
                result: CustomFormat.getFormattedResult(elevationGained),
                unit: 'm',
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return isVertical ? getVerticalLayout() : _createHorizontalLayout();
  }
}
