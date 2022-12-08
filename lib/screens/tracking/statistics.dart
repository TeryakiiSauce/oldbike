import 'package:flutter/material.dart';
import 'package:oldbike/models/screen.dart';

class StatisticsScreen extends StatelessWidget {
  static const TabScreen screen = TabScreen.statistics;

  final double speed, distance, altitude;
  final Duration timeElapsed;

  const StatisticsScreen({
    super.key,
    this.speed = 0.0,
    this.distance = 0.0,
    this.altitude = 0.0,
    this.timeElapsed = const Duration(
      minutes: 1,
      seconds: 30,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('speed: $speed km/h'),
        Text('time elapsed: $timeElapsed minute(s)'),
        Text('distance: $distance km'),
        Text('altitude: $altitude m'),
      ],
    );
  }
}
