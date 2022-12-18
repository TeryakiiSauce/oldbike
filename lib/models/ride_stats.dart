import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:duration/duration.dart';

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

  static RideStatistics createObject(
          QueryDocumentSnapshot<Object?>? rideStatsDoc) =>
      RideStatistics(
        averageSpeed: rideStatsDoc?.get('averageSpeed'),
        currentSpeed: 0.0,
        distanceTravelled: rideStatsDoc?.get('distanceTravelled'),
        downhillDistance: rideStatsDoc?.get('downhillDistance'),
        elevationGained: rideStatsDoc?.get('elevationGained'),
        altitude: 0.0,
        previousAltitude: 0.0,
        minAltitude: rideStatsDoc?.get('minAltitude'),
        maxAltitude: rideStatsDoc?.get('maxAltitude'),
        timeElapsed: parseTime(rideStatsDoc?.get('timeElapsed')),
        topSpeed: rideStatsDoc?.get('topSpeed'),
        uphillDistance: rideStatsDoc?.get('uphillDistance'),
      );

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

  Map<String, dynamic> toJSON() {
    return {
      'topSpeed': topSpeed,
      'averageSpeed': averageSpeed,
      'timeElapsed': timeElapsed.toString(),
      'distanceTravelled': distanceTravelled,
      'minAltitude': minAltitude,
      'maxAltitude': maxAltitude,
      'uphillDistance': uphillDistance,
      'downhillDistance': downhillDistance,
      'elevationGained': elevationGained,
    };
  }

  Future<void> uploadRideStats() async {
    final User? userInfo = MyUser.getUserInfo();

    debugPrint(
      'User ID: ${userInfo?.uid}\ndata to be uploaded: ${toJSON()}',
    );

    // Reference: https://stackoverflow.com/a/55328839
    final CollectionReference rideStatsReference =
        FirebaseFirestore.instance.collection('/rides-statistics');

    await rideStatsReference
        .doc(userInfo!.uid)
        .collection('rides')
        .doc('${DateTime.now()}')
        .set(toJSON());

    debugPrint('uploaded ride stats to database');
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
