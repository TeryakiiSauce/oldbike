///
/// This file aims to build a widget similar to what you would see in the 'Recent Rides' section in the _Profile_ screen of the application.
///
/// Tip: You can use the `HorizontalScroll()` widget if you'd like to display more than one of this `RideInfoCard()` widget.
///
/// Note: This is similar to the `FeedRideInfoCard()` widget.
/// === === === === ===

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/ride_summary_icons.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:oldbike/utils/popup_alerts.dart';
import 'package:oldbike/utils/text_styles.dart';

class RideInfoCard extends StatelessWidget {
  final RideStatistics? rideStatistics;
  final DateTime date;
  final bool hasBorder, detailed, makeAsButton;
  final double height;
  final VoidCallback onClicked;

  /// Creates a card similar to what you would see in the _Recent Rides_ section of the _Profile_ screen.
  const RideInfoCard({
    Key? key,
    required this.date,
    required this.onClicked,
    this.rideStatistics,
    this.height = 0.0,
    this.hasBorder = true,
    this.makeAsButton = true,
    this.detailed = false,
  }) : super(key: key);

  void displayDeletePrompt(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Delete Ride Statistics?'),
        message: const Text(
            'Are you sure that you want to delete the selected ride statistics?'),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) =>
                    CustomPopupAlerts.displayConfirmationToDeleteRideStats(
                  context,
                  date,
                  rideStatistics,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.selectionClick();
        return makeAsButton ? displayDeletePrompt(context) : Container();
      },
      onTap: onClicked,
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'images/robert-bye-tG36rvCeqng-unsplash.jpg',
              fit: BoxFit.cover,
              height: height == 0.0 ? null : height,
              color: kcPrimaryS3.withOpacity(0.8),
              colorBlendMode: BlendMode.srcOver,
            ),
          ),

          // The actual content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Heading
                  Expanded(
                    child: Center(
                      child: Text(
                        CustomFormat.getFormattedDate(date),
                        style: ktsCardDate,
                      ),
                    ),
                  ),

                  // Icons & labels
                  Expanded(
                    flex: 5,
                    child: RideSummaryIcons(
                      avgSpeed: rideStatistics?.averageSpeed ?? 0,
                      distTravelled: rideStatistics?.distanceTravelled ?? 0,
                      elevationGained: rideStatistics?.elevationGained ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
