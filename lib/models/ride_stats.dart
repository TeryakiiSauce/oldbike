import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_icon.dart';
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> latestPostsSnapshots() {
    return latestPostsCollection().snapshots();
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
    await RideStatistics.latestPostsCollection()
        .doc('${DateTime.now()}')
        .set(toJSON());
  }

  Column displayCurrentStats() {
    convertStatsFormat();
    List<Widget> list = [];
    TextStyle titleTS = const TextStyle(
      fontSize: 14.0,
    );
    TextStyle resultTS = const TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w700,
    );
    SizedBox spacing = const SizedBox(
      width: 15.0,
      height: 10.0,
    );

    list.addAll(
      [
        Expanded(
          child: Text('Time Elapsed (Minutes): $timeElapsedStr'),
        ),
        Expanded(
          flex: 3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              // Current Speed
              CircularIcon(
                icon: Icons.flash_on_rounded,
                size: 10.0,
                borderThickness: 5.0,
                isVerticalLayout: true,
                labels: [
                  Text(
                    'Speed\n(Km/h)',
                    style: titleTS,
                    textAlign: TextAlign.center,
                  ),
                  spacing,
                  Text(
                    currentSpeedStr!,
                    style: resultTS,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              spacing,

              // Distance Travelled
              CircularIcon(
                icon: Icons.location_on_rounded,
                size: 10.0,
                borderThickness: 5.0,
                isVerticalLayout: true,
                labels: [
                  Text(
                    'Distance\n(Km)',
                    style: titleTS,
                    textAlign: TextAlign.center,
                  ),
                  spacing,
                  Text(
                    distanceTravelledStr!,
                    style: resultTS,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              spacing,

              // Elevation Gained
              CircularIcon(
                icon: Icons.trending_up_rounded,
                size: 10.0,
                borderThickness: 5.0,
                isVerticalLayout: true,
                labels: [
                  Text(
                    'Elevation\nGained\n(M)',
                    style: titleTS,
                    textAlign: TextAlign.center,
                  ),
                  spacing,
                  Text(
                    elevationGainedStr!,
                    style: resultTS,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              spacing,

              // Altitude
              CircularIcon(
                icon: Icons.cloud_rounded,
                size: 10.0,
                borderThickness: 5.0,
                isVerticalLayout: true,
                labels: [
                  Text(
                    'Current\nAltitude\n(M)',
                    style: titleTS,
                    textAlign: TextAlign.center,
                  ),
                  spacing,
                  Text(
                    altitudeStr!,
                    style: resultTS,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
  }

  ListView displaySummarizedStats() {
    convertStatsFormat();
    List<Widget> list = [];

    TextStyle leadingTS = const TextStyle(fontSize: 16.0);
    TextStyle titleTS = const TextStyle(fontSize: 26.0);
    TextStyle subtitleTS = const TextStyle(fontSize: 13.0);

    list.addAll(
      [
        // Top Speed
        Card(
          child: ListTile(
            leading: Text(
              'Top Speed',
              style: leadingTS,
            ),
            title: Text(
              topSpeedStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Km/h',
              style: subtitleTS,
            ),
          ),
        ),

        // Average Speed
        Card(
          child: ListTile(
            leading: Text(
              'Average Speed',
              style: leadingTS,
            ),
            title: Text(
              averageSpeedStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Km/h',
              style: subtitleTS,
            ),
          ),
        ),

        // Time Elapsed
        Card(
          child: ListTile(
            leading: Text(
              'Time Elapsed',
              style: leadingTS,
            ),
            title: Text(
              timeElapsedStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Minute(s)',
              style: subtitleTS,
            ),
          ),
        ),

        // Distance Travelled
        Card(
          child: ListTile(
            leading: Text(
              'Distance Travelled',
              style: leadingTS,
            ),
            title: Text(
              distanceTravelledStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Kilometres',
              style: subtitleTS,
            ),
          ),
        ),

        // Elevation Gained
        Card(
          child: ListTile(
            leading: Text(
              'Elevation Gained',
              style: leadingTS,
            ),
            title: Text(
              elevationGainedStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Metres',
              style: subtitleTS,
            ),
          ),
        ),

        // Uphill Distance
        Card(
          child: ListTile(
            leading: Text(
              'Uphill Distance',
              style: leadingTS,
            ),
            title: Text(
              uphillDistanceStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Metres',
              style: subtitleTS,
            ),
          ),
        ),

        // Downhill Distance
        Card(
          child: ListTile(
            leading: Text(
              'Downhill Distance',
              style: leadingTS,
            ),
            title: Text(
              downhillDistanceStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Metres',
              style: subtitleTS,
            ),
          ),
        ),

        // Minimum Altitude
        Card(
          child: ListTile(
            leading: Text(
              'Minimum Altitude',
              style: leadingTS,
            ),
            title: Text(
              minAltitudeStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Metres',
              style: subtitleTS,
            ),
          ),
        ),

        // Maximum Altitude
        Card(
          child: ListTile(
            leading: Text(
              'Maximum Altitude',
              style: leadingTS,
            ),
            title: Text(
              maxAltitudeStr!,
              style: titleTS,
            ),
            subtitle: Text(
              'Metres',
              style: subtitleTS,
            ),
          ),
        ),
      ],
    );

    return ListView(
      children: list,
    );
  }
}
