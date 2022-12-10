import 'package:flutter/material.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/custom_formatting.dart';

class StatisticsScreen extends StatefulWidget {
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
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String speed = '', distance = '', altitude = '', timeElapsed = '';

  void reformatResults() {
    speed = CustomFormat.getFormattedNumber(widget.speed, decimalPlace: 2);
    distance =
        CustomFormat.getFormattedNumber(widget.distance, decimalPlace: 2);
    altitude =
        CustomFormat.getFormattedNumber(widget.altitude, decimalPlace: 2);
    timeElapsed =
        '${widget.timeElapsed.inMinutes}:${widget.timeElapsed.inSeconds % 60}';
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
              Text('speed: $speed km/h'),
              Text('time elapsed: $timeElapsed minute(s)'),
              Text('distance: $distance km'),
              Text('altitude: $altitude m'),
            ],
          ),
        ),
      ),
    );
  }
}
