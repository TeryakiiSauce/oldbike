import 'package:flutter/material.dart';
import 'package:oldbike/components/ride_summary_icons.dart';
import 'package:oldbike/utils/custom_formatting.dart';

class CompactRideInfoCard extends StatelessWidget {
  final DateTime date;
  final double height, avgSpeed, distTravelled, elevationGained;
  final bool hasBorder;

  const CompactRideInfoCard({
    Key? key,
    required this.date,
    this.height = 0.0,
    this.avgSpeed = 0.0,
    this.distTravelled = 0.0,
    this.elevationGained = 0.0,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'images/robert-bye-tG36rvCeqng-unsplash.jpg',
            fit: BoxFit.cover,
            height: height == 0.0 ? null : height,
            color: Color(0x40000000),
            colorBlendMode: BlendMode.overlay,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(CustomFormat.getFormattedDate(date)),
              RideSummaryIcons(
                avgSpeed: avgSpeed,
                distTravelled: distTravelled,
                elevationGained: elevationGained,
                // hasBorder: hasBorder,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
