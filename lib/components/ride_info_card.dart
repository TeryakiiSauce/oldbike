///
/// This file aims to build a widget similar to what you would see in the _Home_ screen of the application.
///
/// Note: This is similar to the `RideInfoCard()` widget.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/components/ride_summary_icons.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/utils/colors.dart';

class FeedRideInfoCard extends StatelessWidget {
  final String username;
  final DateTime date;
  final double avgSpeed, distTravelled, elevationGained;

  /// This creates a card that displays a summary of a bike ride.
  ///
  /// Information includes:
  ///   - The average speed.
  ///   - The distance travelled.
  ///   - The elevation gained.
  const FeedRideInfoCard({
    super.key,
    required this.username,
    required this.date,
    this.avgSpeed = 0.0,
    this.distTravelled = 0.0,
    this.elevationGained = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    const SizedBox spacing = SizedBox(
      height: 20.0,
    );

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: kcPrimaryT1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rounded image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset('images/robert-bye-tG36rvCeqng-unsplash.jpg'),
          ),
          spacing,

          // Username Title
          Text(
            username,
            style: ktsCardTitle,
          ),
          const SizedBox(
            height: 5.0,
          ),

          // Date & time info
          Text(
            CustomFormat.getFormattedDate(date),
            style: ktsCardDate,
          ),
          spacing,

          // Horizontal icons group
          RideSummaryIcons(
            avgSpeed: avgSpeed,
            distTravelled: distTravelled,
            elevationGained: elevationGained,
            isVertical: false,
            invertColors: false,
          ),
        ],
      ),
    );
  }
}
