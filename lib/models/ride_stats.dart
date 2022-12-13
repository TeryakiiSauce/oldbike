import 'package:flutter/material.dart';
import 'package:oldbike/utils/custom_formatting.dart';

class RideStatistics {
  double topSpeed,
      currentSpeed,
      averageSpeed,
      distanceTravelled,
      altitude,
      previousAltitude,
      minAltitude,
      maxAltitude,
      uphillDistance,
      downhillDistance,
      elevationGained;
  Duration timeElapsed;

  String? topSpeedStr,
      currentSpeedStr,
      averageSpeedStr,
      distanceTravelledStr,
      altitudeStr,
      previousAltitudeStr,
      minAltitudeStr,
      maxAltitudeStr,
      uphillDistanceStr,
      downhillDistanceStr,
      elevationGainedStr,
      timeElapsedStr;

  RideStatistics({
    required this.averageSpeed,
    required this.currentSpeed,
    required this.distanceTravelled,
    required this.downhillDistance,
    required this.elevationGained,
    required this.altitude,
    required this.previousAltitude,
    required this.minAltitude,
    required this.maxAltitude,
    required this.timeElapsed,
    required this.topSpeed,
    required this.uphillDistance,
  });

  void convertStatsFormat() {
    const int decimalPlaces = 2;

    topSpeedStr = CustomFormat.getFormattedNumber(
      topSpeed,
      decimalPlace: decimalPlaces,
    );

    currentSpeedStr = CustomFormat.getFormattedNumber(
      currentSpeed,
      decimalPlace: decimalPlaces,
    );

    averageSpeedStr = CustomFormat.getFormattedNumber(
      averageSpeed,
      decimalPlace: decimalPlaces,
    );

    distanceTravelledStr = CustomFormat.getFormattedNumber(
      distanceTravelled,
      decimalPlace: decimalPlaces,
    );

    altitudeStr = CustomFormat.getFormattedNumber(
      altitude,
      decimalPlace: decimalPlaces,
    );

    previousAltitudeStr = CustomFormat.getFormattedNumber(
      previousAltitude,
      decimalPlace: decimalPlaces,
    );

    minAltitudeStr = CustomFormat.getFormattedNumber(
      minAltitude,
      decimalPlace: decimalPlaces,
    );

    maxAltitudeStr = CustomFormat.getFormattedNumber(
      maxAltitude,
      decimalPlace: decimalPlaces,
    );

    uphillDistanceStr = CustomFormat.getFormattedNumber(
      uphillDistance,
      decimalPlace: decimalPlaces,
    );

    downhillDistanceStr = CustomFormat.getFormattedNumber(
      downhillDistance,
      decimalPlace: decimalPlaces,
    );

    elevationGainedStr = CustomFormat.getFormattedNumber(
      elevationGained,
      decimalPlace: decimalPlaces,
    );

    timeElapsedStr = '${timeElapsed.inMinutes}:${timeElapsed.inSeconds % 60}';
  }

  Column displayCurrentStats() {
    convertStatsFormat();
    List<Text> list = [];

    list.addAll([
      Text('top speed: $topSpeedStr km/h'),
      Text('current speed: $currentSpeedStr km/h'),
      Text('avg speed: $averageSpeedStr km/h'),
      Text('time elapsed: $timeElapsedStr minute(s)'),
      Text('distance travelled: $distanceTravelledStr km'),
      Text('altitude: $altitudeStr m'),
      Text('min altitude: $minAltitudeStr m'),
      Text('max altitude: $maxAltitudeStr m'),
      Text('uphill distance: $uphillDistanceStr m'),
      Text('downhill distance: $downhillDistanceStr m'),
      Text('elevation gained: $elevationGainedStr m'),
    ]);

    return Column(
      children: list,
    );
  }

// TODO: upload to firebase
  Column displaySummarizedStats() {
    convertStatsFormat();
    List<Text> list = [];

    list.addAll([
      Text('top speed: $topSpeedStr km/h'),
      Text('avg speed: $averageSpeedStr km/h'),
      Text('time elapsed: $timeElapsedStr minute(s)'),
      Text('distance travelled: $distanceTravelledStr km'),
      Text('min altitude: $minAltitudeStr m'),
      Text('max altitude: $maxAltitudeStr m'),
      Text('uphill distance: $uphillDistanceStr m'),
      Text('downhill distance: $downhillDistanceStr m'),
      Text('elevation gained: $elevationGainedStr m'),
    ]);

    return Column(
      children: list,
    );
  }
}
