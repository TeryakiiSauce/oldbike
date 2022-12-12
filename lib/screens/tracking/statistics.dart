import 'package:flutter/material.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/custom_formatting.dart';

class StatisticsScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.statistics;

  // final double speed,
  //     distance,
  //     // altitude,
  //     minAltitude,
  //     maxAltitude,
  //     uphill,
  //     downhill,
  //     elevationGained,
  //     topSpeed,
  //     avgSpeed;
  // final Duration timeElapsed;
  final RideStatistics statsInfo;
  final bool upload;

  // const StatisticsScreen({
  //   super.key,
  //   this.upload = false,
  //   this.speed = 0.0,
  //   this.topSpeed = 0.0,
  //   this.avgSpeed = 0.0,
  //   this.distance = 0.0,
  //   // this.altitude = 0.0,
  //   this.minAltitude = 0.0,
  //   this.maxAltitude = 0.0,
  //   this.uphill = 0.0,
  //   this.downhill = 0.0,
  //   this.elevationGained = 0.0,
  //   this.timeElapsed = const Duration(
  //     minutes: 1,
  //     seconds: 30,
  //   ),
  // });

  const StatisticsScreen({
    super.key,
    required this.statsInfo,
    this.upload = false,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String speed = '',
      distance = '',
      minAltitude = '',
      maxAltitude = '',
      uphill = '',
      downhill = '',
      elevationGained = '',
      timeElapsed = '',
      topSpeed = '',
      avgSpeed = '';

  @override
  void initState() {
    super.initState();

    if (widget.upload) uploadStats();
  }

  void uploadStats() {}

  void reformatResults() {
    topSpeed = CustomFormat.getFormattedNumber(widget.statsInfo.topSpeed,
        decimalPlace: 2);
    avgSpeed = CustomFormat.getFormattedNumber(widget.statsInfo.averageSpeed,
        decimalPlace: 2);
    distance = CustomFormat.getFormattedNumber(
        widget.statsInfo.distanceTravelled,
        decimalPlace: 2);
    timeElapsed =
        '${widget.statsInfo.timeElapsed.inMinutes}:${widget.statsInfo.timeElapsed.inSeconds % 60}';
    minAltitude = CustomFormat.getFormattedNumber(widget.statsInfo.minAltitude,
        decimalPlace: 2);
    maxAltitude = CustomFormat.getFormattedNumber(widget.statsInfo.maxAltitude,
        decimalPlace: 2);
    uphill = CustomFormat.getFormattedNumber(widget.statsInfo.uphillDistance,
        decimalPlace: 2);
    downhill = CustomFormat.getFormattedNumber(
        widget.statsInfo.downhillDistance,
        decimalPlace: 2);
    elevationGained = CustomFormat.getFormattedNumber(
        widget.statsInfo.elevationGained,
        decimalPlace: 2);
  }

  @override
  Widget build(BuildContext context) {
    reformatResults();

    return BaseScreenTemplate(
      title: 'Your Statistics',
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Text('top speed: $topSpeed km/h'),
              Text('current speed: $speed km/h'),
              Text('avg speed: $avgSpeed km/h'),
              Text('time elapsed: $timeElapsed minute(s)'),
              Text('distance: $distance km'),
              Text('min altitude: $minAltitude m'),
              Text('max altitude: $maxAltitude m'),
              Text('uphill distance: $uphill m'),
              Text('downhill distance: $downhill m'),
              Text('elevation gained: $elevationGained m'),
            ],
          ),
        ),
      ),
    );
  }
}
