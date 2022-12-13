import 'package:flutter/material.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';

class StatisticsScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.statistics;
  final RideStatistics statsInfo;
  final bool upload;

  const StatisticsScreen({
    super.key,
    required this.statsInfo,
    this.upload = false,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.upload) uploadStats();
  }

  void uploadStats() {}

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Your Statistics',
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: widget.statsInfo.displaySummarizedStats(),
        ),
      ),
    );
  }
}
