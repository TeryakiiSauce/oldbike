import 'package:cloud_firestore/cloud_firestore.dart';
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
  String cyclistName;

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
    this.cyclistName = 'Anonymous',
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
      QueryDocumentSnapshot<Object?>? rideStatsDoc) {
    return RideStatistics(
      cyclistName: rideStatsDoc?.get('cyclistName'),
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
  }

  static CollectionReference<Map<String, dynamic>> collection() {
    return FirebaseFirestore.instance
        .collection('/rides-statistics')
        .doc(MyUser.getUserInfo()?.uid)
        .collection('rides');
  }

  static CollectionReference<Map<String, dynamic>> latestPostsCollection() {
    return FirebaseFirestore.instance.collection('/latest-posts');
  }

  static DocumentReference<Map<String, dynamic>> document(DateTime dateID) {
    return collection().doc('$dateID');
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> snapshots() {
    return collection().snapshots();
  }

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
      'cyclistName': cyclistName,
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
    debugPrint(
      'User ID: ${MyUser.getUserInfo()?.uid}\ndata to be uploaded: ${toJSON()}',
    );

    await RideStatistics.document(DateTime.now()).set(toJSON());

    debugPrint('uploaded ride stats to database');
  }

  Future<void> postLatestRide() async {
    await RideStatistics.latestPostsCollection().doc().set(toJSON());
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
