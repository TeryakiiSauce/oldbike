import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_icon.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:oldbike/utils/text_styles.dart';

/// The class below is used to arrange the average speed, distance travelled, & elevation gained icons & labels neatly.
///
/// It does this with the help of my _two_ carefully created custom widgets `CircularIcon()` & `CircularIconLabel()` lol. It took me some time for figure it out because navigating through multiple files made me lose focus.
///
class RideSummaryIcons extends StatelessWidget {
  // To adjust design quickly
  final double borderThickness = 5.0;

  final bool isVertical, invertColors;
  final double avgSpeed, distTravelled, elevationGained;

  final SizedBox _vSpacing = const SizedBox(
    height: 10.0,
  );

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
  Column getVerticalLayout() => Column(
        children: [
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Average\nSpeed',
                  textAlign: TextAlign.center,
                ),
                Text(
                  CustomFormat.getFormattedResult(avgSpeed),
                  style: ktsCardTitle,
                ),
                const Text(
                  'KM/H',
                ),
              ],
              icon: Icons.flash_on_rounded,
              invertedColors: true,
              borderThickness: 4,
              size: 15,
            ),
          ),
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Distance\nTravelled',
                  textAlign: TextAlign.center,
                ),
                Text(
                  CustomFormat.getFormattedResult(distTravelled),
                  style: ktsCardTitle,
                ),
                const Text(
                  'KM',
                ),
              ],
              icon: Icons.location_on_rounded,
              invertedColors: true,
              borderThickness: 4,
              size: 15,
            ),
          ),
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Elevation\nGained',
                  textAlign: TextAlign.center,
                ),
                Text(
                  CustomFormat.getFormattedResult(elevationGained),
                  style: ktsCardTitle,
                ),
                const Text(
                  'M',
                ),
              ],
              icon: Icons.trending_up_rounded,
              invertedColors: true,
              borderThickness: 4,
              size: 15,
            ),
          ),
        ],
      );

  /// Creates _three_ icons (with labels if specified) next to each other.
  Row _createHorizontalLayout() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Average\nSpeed',
                  textAlign: TextAlign.center,
                ),
                _vSpacing,
                Text(
                  CustomFormat.getFormattedResult(avgSpeed),
                  style: ktsCardTitle,
                ),
                _vSpacing,
                const Text(
                  'KM/H',
                ),
              ],
              icon: Icons.flash_on_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              isVerticalLayout: true,
            ),
          ),
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Distance\nTravelled',
                  textAlign: TextAlign.center,
                ),
                _vSpacing,
                Text(
                  CustomFormat.getFormattedResult(distTravelled),
                  style: ktsCardTitle,
                ),
                _vSpacing,
                const Text(
                  'KM',
                ),
              ],
              icon: Icons.location_on_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              isVerticalLayout: true,
            ),
          ),
          Expanded(
            child: CircularIcon(
              labels: [
                const Text(
                  'Elevation\nGained',
                  textAlign: TextAlign.center,
                ),
                _vSpacing,
                Text(
                  CustomFormat.getFormattedResult(elevationGained),
                  style: ktsCardTitle,
                ),
                _vSpacing,
                const Text(
                  'M',
                ),
              ],
              icon: Icons.trending_up_rounded,
              borderThickness: borderThickness,
              invertedColors: invertColors,
              isVerticalLayout: true,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return isVertical ? getVerticalLayout() : _createHorizontalLayout();
  }
}