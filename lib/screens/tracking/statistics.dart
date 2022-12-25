import 'package:flutter/material.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';

class StatisticsScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.statistics;
  final RideStatistics statsInfo;
  final bool doUpload, doPost;
  final String screenTitle;

  const StatisticsScreen({
    super.key,
    required this.statsInfo,
    this.screenTitle = 'Your Statistics',
    this.doUpload = false,
    this.doPost = true,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.doUpload) widget.statsInfo.uploadRideStats();
    if (widget.doPost) widget.statsInfo.postLatestRide();

    return BaseScreenTemplate(
      title: widget.screenTitle,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: widget.statsInfo.displaySummarizedStats(),
      ),
    );
  }
}
